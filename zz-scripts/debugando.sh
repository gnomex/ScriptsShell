#!/bin/bash
##debugando.sh
#
#	Funções para debugar scripts
#
# Versão 1: Funções de debug
#
################################################################################
#
# Autor: Kenner Kliemann , kenner.kliemann@itai.org.br
#	
#	Licença: GPL
#	Agosto de 2012
################################################################################

#Variaveis

#DEBUG=0

#Para debug categorizado
DEBUG=${1:-0}

#Funções
Debug(){
	[ "$DEBUG" = 1 ] && echo "-----------{ $*"

}

DebugColor(){
	[ "$DEBUG" = 1 ] && echo -e "\033[33;1m$*\033[m"

}

DebugLevels(){
	[ $1 -le $DEBUG ] && echo "------ DEBUG $*"
}

DebugParrudo(){
	[ $1 -le $DEBUG ] || return
	local prefixo
	case "$1" in
		1) prefixo="-- ";;
		2) prefixo="---- ";;
		3) prefixo="------ ";;
		4) prefixo="++------ ";;
		*) echo "Mensagem nao categorizada: $*"; return;;
	esac
	shift
	
	echo $prefixo$*

}

#Exemplo de debug categorizado em 3 niveis

DebugLevels 1 "Inicio do programa"

i=0
max=5
echo "Contando até $max"

DebugLevels 2 "Vou entrar no loooop"

while [ $i -ne $max ]; do
	
	DebugLevels 4 "Valor de \$i antes de incrementar: $i"
	let i=$i+1
	DebugLevels 4 "Valor de \$i depois de incrementar: $i"
	
	echo "$i..."
done

DebugLevels 2 "Sai do Loooop"

echo "Terminei!"

DebugLevels 1 "Fim do programa"





