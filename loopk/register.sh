#!/bin/bash
#	register.sh
#		util functions to loopk
##


## Melhorando esta funcionalidade
function errorreport {
	#Escuta a porta e redireciona para arquivo de erro
	`cat "$DEVICE" >> "$LOGFILE"`
}
