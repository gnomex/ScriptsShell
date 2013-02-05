#!/bin/bash
#
#	Writing nothing on a file
#

FILE='writer'
NUMOFJOBS=1

function writeLOL () {
	
	local SLEEPTIME="$1"
	
	while true ; do
		
		for i in $(seq 1 5)
		do	
			sleep "$SLEEPTIME"
			echo "My PID $$"
			echo "Counter: $i and Sleep $SLEEPTIME"
			echo "JOBS: $NUMOFJOBS"
		done
	done
	
} >> "$FILE"

function troll {
	#set -x
	local SleeperTiming=1
	while true ; do
		if test "$NUMOFJOBS" -lt 20 ; then #Limit of jobs, remove conditional to be happy
			writeLOL "$SleeperTiming" &
			echo "$!"
			NUMOFJOBS=$((NUMOFJOBS+1))
			SleeperTiming=$((SleeperTiming+1))
			sleep 1.5
			writeLOL "$SleeperTiming" &
			echo "$!"
			SleeperTiming=$((SleeperTiming+1))
			NUMOFJOBS=$((NUMOFJOBS+1))
			echo 'Writing on a file'
			echo 'Trolling you'
			troll &
			echo "New Job: $!"
			NUMOFJOBS=$((NUMOFJOBS+1))
		else
			echo 'Limit Exceeded of Jobs, Killing AlL' #>> "$FILE"
			killall -9 $(basename $0)
		fi
	done
	
}

troll


