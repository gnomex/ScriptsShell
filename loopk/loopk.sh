#!/bin/bash
##loopk.sh
#
##Description
#	Signal conditioning to WatchDog device
#
##Require root privileges
#
# Version 1: Send char signal to device
# Version 2: Updating logging
# Version 3: Dinamic time
# Version 4: Solving bugs and refactor the code
# Version 5: Job control
#
##
# Author: Kenner Alan Kliemann <kenner.kliemann@itai.org.br>
#	Aug, 2012 
##

#Includes
#source logger.sh

#Vars
LOGDIR='log'
LOGFILE="$LOGDIR/monitor.log"
LOGERRORFILE="$LOGDIR/logger.log"
TIMEINTERVAL=2 	#Default value
UPTIMESCRIPT="$(date +%d/%m/%Y-%H:%M:%S)"

SIGINT=15

#Functions

function ShowHelp	{
	local HELPMESSAGE="
	USO: $(basename "$0") [-h | -V | -f <file>]

	-h	Show help
	-V	Show Version
	-f <file>	Input file
	-t <time [float]>	time delay, Default is 2
	
	#Examples:
		# $(basename "$0") -f /dev/ttyACM0
		# $(basename "$0") -f /dev/ttyACM0 -t 1.2
		# $(basename "$0") -f /dev/ttyACM0 -t 3
	"
	echo "$HELPMESSAGE"
}

function ShowVersion {
	echo -n $(basename "$0")
	local version=$(grep '^# Version ' "$0" | tail -1 | cut -d : -f 1 | tr -d \#)
	echo "$version"
	local author=$(grep '^# Author:' "$0" | tail -1 | cut -d : -f 1- | tr -d \#)
	echo "$author"
}

function file_exists_notempty {
    if test -c "$1" ;
    then
    	newevent "Device $1 found!"
        return 0
	else
		newevent "Error: $1 not found or not a valid character device!"
		exit 1 	
	fi
}

function initheaderlog {
local MENSAGEMINICIOLOG="
###############################################################################
#	Start as $(date +%d/%m/%Y-%H:%M:%S)
#	Device: $DEVICE
#	Uptime: $UPTIMESCRIPT
###############################################################################
"
	newevent "$MENSAGEMINICIOLOG"
}

function endlog	{
	newevent '###############################################################################'
}

function newevent () {
	#Append Messages on logfile
	echo "$1" >> "$LOGFILE"
}

function errorreport {
	#PID of atual process chield
	addJOBID "$$"
	cat "$DEVICE" > "$LOGERRORFILE"
}

function sentK {
	# While device is connected
	while test -c "$DEVICE"
	do
		#write k on tty
		echo 'K' > "$DEVICE"
		if test "$?" -eq 0 ;
			then
				newevent "K sent to device"
			else
				newevent "Error: k not sent !!!"
		fi
		sleep "$TIMEINTERVAL"
	done
	newevent "loopk stoped! at: $(date +%d/%m/%Y-%H:%M:%S)"
}

function __logger	{

	local counter="$(wc -c $LOGERRORFILE | cut -d ' ' -f 1)"	#log file size

	if test "$counter" -nq 0 ;
	then
		newevent 'WARNING: log file has not empty'
	else
		newevent 'Logger has working!'
	fi

	#while device is connected
	while test -c "$DEVICE"
	do
		if test "$(wc -c $LOGERRORFILE | cut -d ' ' -f 1)" -gt "$counter" ; 
		then
			newevent "Reading error from device! - at: $(date +%d/%m/%Y-%H:%M:%S)"
		fi
	done
}

#Mostra graficamente o log
function ShowDialogLOG	{
	dialog --no-shadow \
		--begin 0 0 --title 'Monitor' --tailbox "$LOGFILE" 24 80
}

#function ShowZenityLOG	{
#
#}

#Setting device input port tty to raw mode
function setRawTTY {
	set -x 
		#Setting the serial port to raw mode
		stty raw -F "$DEVICE"
		if test "$?" -eq '0' ; 
		then
			newevent "Device $DEVICE setted to raw mode"
		else
			newevent "ERROR: Device $DEVICE  NOT setted to raw mode"
		fi
	set +x
}

#Inicialize monitor
function __init {

	#Init header log
	initheaderlog

	file_exists_notempty "$DEVICE"

	setRawTTY

	#Bash jobs control
	set -m
	set -b

	#@Job
	__logger &
	addJOBID "$!"

	(errorreport & )	#pooling error in new shell
	#@BUG: no PID
	addJOBID "$!"

	#@Job
	sentK & 	#Inicia envio de "K"
	addJOBID "$!"

	ShowDialogLOG

	#Disable Bash jobs control
	set +b
	set +m
}

function __SIGKILL {
	
	local arraysize="${#PJOBSIDS[@]}"
	newevent "Total jobs running: $arraysize"
	newevent "PIDs: ${PJOBSIDS[@]}"
	#Kill jobs
	for ((i=0;i<"$arraysize";i++)) ;
	do
		echo "Killing job PID: ${NUMOFJOBS[$i]}"
		kill "-$SIGINT" "${PJOBSIDS[$i]}" ;
	done

	killall	"-$SIGINT" "$(basename $0)"
}

function addJOBID ()	{

	local arraysize="${#PJOBSIDS[@]}"	#length of array
	PJOBSIDS[arraysize]="$1"	#add the arg on array
	newevent "Job listed: $1"

}

#Tratamento das opçoes da linha de comando
while getopts ":hVf:t:" OPCAO
do
	case "$OPCAO" in
		h)	ShowHelp
			exit 0
			;;
		V)	ShowVersion
			exit 0
			;;
		f)	DEVICE="$OPTARG"	
			echo "File input: $DEVICE"
			;;
		t)	TIMEINTERVAL="$OPTARG"
			;;
		\?)	echo "ERROR, Invalid arg to: $OPTARG"	
			exit 1
			;;
		:)	echo "not found arg to $OPTARG"		
			exit 1
			;;
	esac
done

__init
__SIGKILL
endlog
exit 0
###########################################################################EOF.