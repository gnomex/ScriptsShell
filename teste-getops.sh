#!/bin/bash
#teste-getops
#
##Testa parametros passados usando getopts
#
# Versão 1: 
#
################################################################################
#
# Autor: Kenner Kliemann , kenner.kliemann@itai.org.br
#	
#	Licença: GPL
#	Agosto de 2012
################################################################################
#
# sa são os paramentros aceitos
# :sa diz para o getopts trabalhar em modo silencioso sem apresentar
#	os erros por dados incorretos
# sa: diz que o argumento a: vai receber argumento
#

while getopts ":sa:f:" opcao
do
	case $opcao in
		s)	echo "OK (-s)"	;;
		a)	echo "OK (-a), Argumento: $OPTARG"	;;
		\?)	echo "ERRO, Argumento inválido: $OPTARG"	;;
		:)	echo "Faltou argumento para $OPTARG"	;;
		f)	echo "OK (-f) File: $OPTARG"	;;
	esac
done

echo
shift $((OPTIND - 1))
echo "INDICE: $OPTIND"
echo "RESTO: $*"
echo
