#!/bin/bash
##debugando.sh
#
#	Funções para debugar scripts
#
# Versão 1
#
################################################################################
#
# Autor: Kenner Kliemann , kenner.kliemann@itai.org.br
#	
#	Licença: GPL
#	Agosto de 2012
################################################################################

#Variaveis

DEBUG=0

#Funções
Debug(){
	[ "$DEBUG" = 1 ] && echo "-----------{ $*"

}

DebugColor(){
	[ "$DEBUG" = 1 ] && echo -e "\033[33;1m$*\033[m"

}
