#!/bin/bash
#usuarios.sh
#
#Mostra os logins e nomes de usuários do sistema
#Obs.: Lê dados do arquivo /etc/passwd
#
# Versão 1: Mostra usuários e nomes separados por TAB
# Versão 2: Adicionando suporte à opção -h
# Versão 3: Adicionando suporte à opção -V e opções inválidas
# Versão 4: Arrumando bug quando não tem opções, basename no 
#	   nome do programa, -V extraindo direto dos cabeçalhos,
#	   adicionadas opções --help e --version
# Versão 5: Adicionando visualização ordenada  -s --sort
# Versão 6: Adicionando ordem inversa para o --sort e uppercase
# Versão 7: Adicionando suporte a delimitadores
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
	USO: $(basename "$0") [-h | -V | -s | -d <char>]
	-h, --help	Ajuda
	-V, --version 	Mostra versão do programa e sai
	-s, --sort [--reverse, --upper]		Mostra saída ordenada
	-r, --reverse	Mostra saida ordenada em ordem inversa
	-u, --uppercase	Mostra saida toda em letras maiusculas
	-d, --delimiter	Delimitador de string
"

#Flags

SORT=0	#A saida será ordenada ?
REVERSE=0	#Ordenação inversa ?
TOUPPER=0	#Tudo em uppercase ?
DELIM="\\t"

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
while test -n "$1"
do
	case "$1" in
		-s | --sort	)	SORT=1		;;
		-r | --reverse	)	REVERSE=1	;;
		-u | --uppercase)	TOUPPER=1	;;
		-h | --help	)	echo "$MENSAGEMUSO"
					exit 0		;;
		-V | --version	)	mostrarversao	;;
		
		-d | --delimiter)
			shift
			DELIM="$1"
			
			if test -z "$DELIM"
			then
				echo "Faltou argumento delimitador para opção -d"
				exit 1
			fi		
		;;	
		*)
			if test -n "$1"
			then
				echo "Opcao invalida: $1"
				exit 1
			fi
		;;
	esac
	#opção 1 já processada, a fila deve andar
	shift
done

#Processamento
#Extrai listagem
lista=$(cut -d : -f 1,5 /etc/passwd)

#Ordena listagem (Se necessário)
test "$SORT" = 1 && lista=$(echo "$lista" | sort)
#Inverte listagem
test "$REVERSE" = 1 && lista=$(echo "$lista" | tac)
#Passa saida para maiusculo
test "$TOUPPER" = 1 && lista=$(echo "$lista" | tr a-z A-Z)

#Mostra resultado para usuário
echo "$lista" | tr : "$DELIM"

exit 0		
