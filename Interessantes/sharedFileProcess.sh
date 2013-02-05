#!/bin/bash
#
#	Test of writing on a file with various jobs
#
#	Author: Kenner Kliemann, kenner.hp@gmail.com
#Jan 2013
#	
##Params requires:
#@basename
#@PID of job
#@Args to write

#Vars
FILESHARED='writerShared'
FILELOG='logwriter'

USAGE="
	Uses: $(basename "$0") []
		-h help
		-p <job|process PID>
		-b <basename>
		-a <Args to write>
		-f <fileShared>

		examples:
			$(basename "$0") -p 12345 -b teste.sh -a 'Testing this test'
			$(basename "$0") -p 12345 -b teste.sh -a 'Testing this test' -f sharedFilepath
"

function writeOnFile () {
	set -x	#Enable debug

	set +x	#Disable debug
}

#Param
#@message
function logger () {
	set -x	#Enable debug

	set +x	#Disable debug
}


if test "$#" -eq 3 ; #Require 3 params
then
	while getopts ":p:b:a:" PARAMS
			do
				case "$PARAMS" in
					p)	CurrentPID="$OPTARG";;
					b)	CurrentPIDBasename="$OPTARG";;
					a)	CurrentMessage="$OPTARG";;
					\?)	echo "Error - Argument invalid: $OPTARG"	;;
					:)	echo "Error - arguments not found: $OPTARG"	;;	
				esac
			done

else

fi