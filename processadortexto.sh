#!/bin/bash
##processadortexto.sh
#	Procura texto especifico a partir de delimitadores e processa resultado
#	com base na hora do registro
#
##Obs: script com objetivo de processar log de evento
#
# Versão 1: Funcionalidades de busca por delimitador dentro do arquivo de log
#
################################################################################
#
# Autor: Kenner Kliemann , kenner.kliemann@itai.org.br
#	
#	Licença: GPL
#	Agosto de 2012
################################################################################

#Variaveis

MENSAGEMUSO="
	USO: $(basename "$0") [ h| V| f <file input>| d <delimitador>| c <carater de busca>|
	
	+-h	Mostra ajuda e sai
	+-V	Mostra versão e sai
	--f	Arquivo a de entrada
	--d	Delimitador de busca
	--c	Caracter de busca
	
	Exemplos:
		$(basename "$0")	
"

#Flags



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





#Tratamento das opções de linha de comando
while getopts ":hVf:d:c:" OPCAO
do
	case "$OPCAO" in
		f)		;;
		d)		;;
		c)		;;
		h)	echo "$MENSAGEMUSO"
			exit 0		;;
		V)	mostrarversao	;;	
		\?)	echo "ERRO, Argumento inválido: $OPTARG"	;;
		:)	echo "Faltou argumento para $OPTARG"	;;
		
	esac
done

#Processamento
