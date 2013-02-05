#!/bin/bash
##eventos.sh
#
##Descrição
#	Analisa arquivo de log e retorna se encontrou delimitador de erro
#
##Funcionamento
#	Recebe como parametro o arquivo de log
#	Analisa a ultima linha do aqruivo a fim de encontrar string de erro
#	Retorna 0 se nao foi encontrado
#	Retorna 1 se encontrou
#
# Versão 1: implementação do suporte a registro de eventos, sem verificação e
#			validação de parametros
#
################################################
# 
# Autor: Kenner Alan Kliemann <kenner.kliemann@itai.org.br>
# 
#	Agosto de 2012 
#
##

function registraevento () {

	local LOGFILE="$1"

	test -e "$LOGFILE" || echo "Dont Work!" exit 2
		
	#Buffer de erro= 'F' ou 'Teste'

	achou=$(tail -1 "$LOGFILE" | grep  -E "(^Teste |teste |F$)"  )
	if test ${#achou} -ne '0' 
	then
		#Se encontrou
		return 1
	else
		return 0
	fi

}

