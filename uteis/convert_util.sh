#!/bin/bash
#	Utilitário para uso do programa convert
#
# Version 1: redimensiona imagens jpg
#
#
################################################################################
#
# Author: Kenner Kliemann , kenner.kliemann@itai.org.br
#	
#	Jan 2013
################################################################################

FILECOUNTER='files'

MENSAGEMUSO="
	USO: $(basename "$0") [-h | -v | -s scale]
		-h help
		-v version
		-s <scale> --Necessary - no have default value

		examples:
			$(basename "$0") -s 130x130
			$(basename "$0") -s 50%

	Only converts jpg yet !!!

	Needs more ?
		:~$ man convert
"
#Funções
function showVersion {
	echo -n $(basename "$0")
	#Extrai a versão diretamente dos cabeçalhos do programa
	local version=$(grep '^# Version ' "$0" | tail -1 | cut -d : -f 1 | tr -d \#)
	echo "$version"
	local author=$(grep '^# Author:' "$0" | tail -1 | cut -d : -f 1- | tr -d \#)
	echo "$author"
	exit 0
}

function resizer (){
	local NAME="$1"
	local NEWNAME="$( echo "$NAME" | cut -d . -f 1)_s.png"

	echo "Converting: $NAME scale: $SCALE , new name: $NEWNAME"
	convert "$NAME" -resize "$SCALE" "$NEWNAME"
	echo "done"
}

function findFiles {
	#Procura arquivos com extensão jpg
	ls |grep -e  ".[JPG|jpg]" > "$FILECOUNTER"

	local NFILES=$(wc -l "$FILECOUNTER")
	echo "found $NFILES!"
}

function iteratorDir {

	if test -f "$FILECOUNTER"
		then
			cat "$FILECOUNTER" | while read LINHA; do resizer "$LINHA"; done
		else
			echo 'Arquivo de contagem não encontrado'
			return 1
	fi
}

function removeTempFiles {

	rm -rf "$FILECOUNTER"	
}

#Tratamento das opções de linha de comando
while getopts ":hvd:s:" OPCAO
do
	case "$OPCAO" in
		v)	showVersion	;;
		h)	echo "$MENSAGEMUSO"
			exit 0		;;
		s)	SCALE="$OPTARG"	

		findFiles
		iteratorDir
		removeTempFiles
		;;
		
		\?)	echo "ERRO, Argumento inválido: $OPTARG"	;;
		:)	echo "Faltou argumento para $OPTARG"	;;
		
	esac
done
