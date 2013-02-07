#!/bin/bash
#
#	Writing nothing on a file
#

#arraysize="${#NUMOFJOBS[@]}"	#length of array
#NUMOFJOBS[arraysize]="$$" #inicializando array
#echo "PID: ${NUMOFJOBS[@]}"

FILE='writer'

function writeLOL () {
	
	local SLEEPTIME="$1"
	
	while true ; do
		
		for i in $(seq 1 5)
		do	
			sleep "$SLEEPTIME"
			echo "Counter: $i and Sleep $SLEEPTIME"
		done
	done
	
} >> "$FILE"


function __SIGKILL {
	
	local arraysize="${#NUMOFJOBS[@]}"
	#Kill jobs
	for ((i=0;i<"$arraysize";i++)) ;
	do
		echo "Killing job PID: ${NUMOFJOBS[$i]}"
		kill -9 "${NUMOFJOBS[$i]}" ;
	done

	killall -9 "$(basename $0)"

}

function addJOBID ()	{

	local arraysize="${#NUMOFJOBS[@]}"	#length of array
	NUMOFJOBS[arraysize]="$1"	#add the arg on array
	echo "Job listed: $1"

}


function troll {

	set -m
	set -b

	local SleeperTiming=1
	while true ; do
		if test "${#NUMOFJOBS[@]}" -lt 5 ; then #Limit of jobs, remove conditional to be happy
			
			writeLOL "$SleeperTiming" &
			addJOBID "$!"

			SleeperTiming=$((SleeperTiming+1))
			sleep "$SleeperTiming"

			writeLOL "$SleeperTiming" &
			addJOBID "$!"

			SleeperTiming=$((SleeperTiming+1))
			
			echo 'Writing on a file'
			echo 'Trolling you'
			echo "Num of active jobs: ${#NUMOFJOBS[@]}"
			sleep "$SleeperTiming"

			#troll &
			#addJOBID "$!"

		else
			echo 'Limit Exceeded of Jobs, Killing AlL'
			echo "${NUMOFJOBS[@]}"
			return 0
		fi
	done
	set +m
	set +b
}

troll
__SIGKILL

