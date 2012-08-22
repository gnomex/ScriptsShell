#!/bin/bash
#
#cores.sh
#	Mostra paleta de cores disponiveis no console
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

for letra in 0 1 2 3 4 5 6 7; do	#Linhas: cores das letras
	for brilho in '' ';1'; do	#liga/desliga brilho
		for fundo in 0 1 2 3 4 5 6 7; do	#Colunas: cores de fundo
			seq="4$fundo;3$letra"		#Compoem código de cores
			echo -e "\033[$seq${brilho}m\c"	#liga a cores
			echo -e " $seq${brilho:- } \c"	#Mostra o código na tela
			echo -e "\033[m\c"		#Desliga a cor
		done; echo	#quebra a linha
	done
done
