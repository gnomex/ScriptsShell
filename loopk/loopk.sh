#!/bin/bash
##loopk.sh
#
##Description
#	Signal conditioning to WatchDog device
#
##Require root privileges
#
# Version 1: Suporte a envio de caracter "K" com log grafico
# Version 2: Melhorias no supporte a log
# Version 3: Suporte a parametro de tempo de envio e melhorias no gerador de log
# Version 4: Melhoria da estrutura lógica e solução do bug de não leitura de erro
#
##
# Author: Kenner Alan Kliemann <kenner.kliemann@itai.org.br>
#	Aug, 2012 
##

#Includes
source register.sh

#Vars
LOGDIR='log'
LOGFILE="$LOGDIR/monitor.log"
TIMEINTERVAL=2
UPTIMESCRIPT="$(date +%d/%m/%Y-%H:%M:%S)"

#Functions

function ShowHelp	{
	local HELPMESSAGE="
	USO: $(basename "$0") [-h | -V | -f <file>]

	-h	Show help
	-V	Show Version
	-f <file>	Input file
	-t <time [float]>	time delay
	
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
		return 1 	
	fi
}

function initheaderlog {
local MENSAGEMINICIOLOG="
#############################################
#	Start as $(date +%d/%m/%Y-%H:%M:%S)
#	Device: $DEVICE
#	Uptime: $UPTIMESCRIPT
##
"
	newevent "$MENSAGEMINICIOLOG"
}

function newevent () {
	#Append Messages on logfile
	echo "$1" >> "$LOGFILE"
}


function sentK {
	
	while [ -c "$DEVICE" ]
	do
		#write k on tty
		echo 'K' >> "$DEVICE"
		if test "$?" -eq 0 ;
			then
				newevent "K sent to device"
			else
				newevent "Error: k not set !!!"
		fi
		sleep "$TIMEINTERVAL"
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

	file_exists_notempty "$DEVICE"
	#Inicia Logs
	initheaderlog

	setRawTTY

	#Extern script2
	./errorreport "$LOGFILE"	#pooling error
	
	#@Job
	sentK & 	#Inicia envio de "K"

	ShowLOG	
}

function __SIGNALREVEIVER {
	#Kill jobs
	killall -15 $(basename "$0")

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
__SIGNALREVEIVER

################################################EOF.