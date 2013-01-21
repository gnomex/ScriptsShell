#!/bin/bash
#	Utilitário para uso do programa convert
#
# Versão 1: redimensiona imagens jpg
#
#
################################################################################
#
# Autor: Kenner Kliemann , kenner.kliemann@itai.org.br
#	
#	Jan 2013
################################################################################

FILECOUNTER='files'

MENSAGEMUSO="
	USO: $(basename "$0") [-h | -d dir | -s scale]
		-h help
		-d <dir> --default:none
		-s <scale> --Necessary - no have default value

		examples:
			$(basename "$0") -d ~/Images/ -s 130x130
			$(basename "$0") -s 130x130

	Only converts jpg yet !!!

	Needs more ?
		:~$ man convert
"
#Funções
function resizer (){
	local NAME="$1"
	local NEWNAME="$( echo "$NAME" | cut -d . -f 1)_s.png"

	convert "$NAME" -resize "$SCALE" "$NEWNAME"

}

function findFiles {
	#Procura arquivos com extensão jpg
	ls "$DIR" |grep -e  ".[JPG|jpg]" > "$FILECOUNTER"

	local NFILES=$(wc -l "$FILECOUNTER")
	echo "found $NFILES!"
}

function iteratorDir {

	if test -f "$FILECOUNTER"
		then
			INPUTFILE=$(cat -n $FILECOUNTER)
			for i in "$INPUTFILE"
			do
				resizer "$i"
			done	
			#Remove Arquivo temporario
			#rm -rf files.txt
		else
			echo 'Arquivo de contagem não encontrado'
	fi

}

function removeTempFiles {

	rm -rf "$FILECOUNTER"	
}

#Tratamento das opções de linha de comando
while getopts ":hd:s:" OPCAO
do
	case "$OPCAO" in
		f)	FILE="$OPTARG"		;;
		d)	DIR="OPTARG"	;;
		h)	echo "$MENSAGEMUSO"
			exit 0		;;
		s)	SCALE="$OPTARG"	;;
		
		\?)	echo "ERRO, Argumento inválido: $OPTARG"	;;
		:)	echo "Faltou argumento para $OPTARG"	;;
		
	esac
done

findFiles
iteratorDir
removeTempFiles
