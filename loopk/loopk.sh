#!/bin/bash
##loopk.sh
#
##Descrição
#	Envio de caracter "K" para dispositivo com delay de n segundos
#
# Versão 1: Suporte a envio de caracter "K" com log grafico
# Versão 2: Melhorias no supporte a log
# Versão 3: Suporte a parametro de tempo de envio e melhorias no gerador de log
# Versão 4: Melhoria da estrutura lógica e solução do bug de não leitura de erro
#
################################################
# 
# Autor: Kenner Alan Kliemann <kenner.kliemann@itai.org.br>
# 
#	Agosto de 2012 
#
##

#Scripts externos

source eventos.sh

#Variáveis
LOGDIR='log'
LOGFILE="$LOGDIR/monitor.log"
TIMEINTERVAL=2
UPTIMESCRIPT="$(date +%d/%m/%Y-%H:%M:%S)"

MENSAGEMUSO="
	USO: $(basename "$0") [-h | -V | -f <file>]

	+ -h	Mostra Ajuda e sai
	+ -V	Mostra versão do programa e sai
	+ -f <file>	Arquivo de entrada
	+ -t <time [float]>	tempo de delay
	
	#Exemplos:
		$(basename "$0") -f /dev/ttyACM0
		$(basename "$0") -f /dev/ttyACM0 -t 1.2
		$(basename "$0") -f /dev/ttyACM0 -t 3
	"


#Funções

function mostrarversao {
	echo -n $(basename "$0")
	#Extrai a versão diretamente dos cabeçalhos do programa
	local version=$(grep '^# Versão ' "$0" | tail -1 | cut -d : -f 1 | tr -d \#)
	echo "$version"
	local author=$(grep '^# Autor:' "$0" | tail -1 | cut -d : -f 1- | tr -d \#)
	echo "$author"
	exit 0
}

function file_exists_notempty {
    if test -c "$1" ;
    then
        return 0
	else
		return 1 	
	fi
}

function initheaderlog {
local MENSAGEMINICIOLOG="
#############################################
#	Iniciado em: $(date +%d/%m/%Y-%H:%M:%S)
#	Dispositivo: $DEVICE
#	Uptime: $UPTIMESCRIPT
##
"
	newevent "$MENSAGEMINICIOLOG"

}


## Melhorando esta funcionalidade
function errorreport {
	#Escuta a porta e redireciona para arquivo de erro
	cat "$DEVICE" >> "$LOGFILE"
}

function newevent () {
	#Append Messages on logfile
	echo "$1" >> "$LOGFILE"
}


function sentK {
	
	while test $(file_exists_notempty) -eq 0 ;
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
function ShowLOG {
	
	dialog --no-shadow \
		--begin 0 0 --title 'Monitor' --tailbox "$LOGFILE" 24 80
}

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

	errorreport &	#pooling error

	sentK & 	#Inicia envio de "K"

	ShowLOG	
}

function __SIGNALREVEIVER {
	#Kill jobs
	kill -15 $(basename "$0")

}


#Tratamento das opçoes da linha de comando
while getopts ":hVf:t:" OPCAO
do
	case "$OPCAO" in
		h)	echo "$MENSAGEMUSO"
			exit 0		;;
		V)	mostrarversao	;;
		f)	DEVICE="$OPTARG"	
			echo "Arquivo de entrada: $DEVICE";;
		t)	TIMEINTERVAL="$OPTARG"	;;
		\?)	echo "ERRO, Argumento inválido: $OPTARG"	
			exit 1	;;
		:)	echo "Faltou argumento para $OPTARG"		
			exit 1	;;
	esac
done

__SIGNALREVEIVER

################################################EOF.