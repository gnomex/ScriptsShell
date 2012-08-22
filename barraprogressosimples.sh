#!/bin/bash
#
#gauge.sh
#	Mostra paleta de cores disponiveis no console
#
# [.............................................] 0%
# [#######################......................] 50%
# [#############################################] 100%
#
################################################################################
#
# Autor: Kenner Kliemann , kenner.kliemann@itai.org.br
#	
#	Licença: GPL
#	Agosto de 2012
################################################################################

passo='\033[40;31m #### \033[m'

for i in 10 20 30 40 50 60 70 80 90 100; do
	sleep 1
	pos=$((i/2-5))		#Calcula a posição da atual barra
	echo -ne '\033[G'	#vai para começo da linha
	echo -ne "\033[${pos}C"	#vai para posição atual da barra
	echo -ne "$passo"	#preenche mais um passo
	echo -ne '\033[53G'	#vai para a posição da porcentagem
	echo -n "| $i %"		#mostra a porcentagem
done
echo
