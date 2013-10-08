#!/bin/bash
#  Recebe um código formado pela soma de 4 tipos
#+ de erro e dá as msgs correspondentes. Assim,
#+ se houveram erros tipo 4 e 2, o script receberá 6
#+ Se os erros foram 1 e 2, será passado 3. Enfim
#+ os códigos de erro seguem uma formação binária.

Bin=$(bc <<< "obase=2; $1")  # Passa para binário
Zeros=0000
Len=${#Bin}                  # Pega tamanho de $Bin
Bin=${Zeros:$Len}$Bin        # Preenche com zeros à esquerda
#  Poderíamos fazer o mesmo que foi feito acima
#+ com um cmd printf, como veremos no capítulo 6
case $Bin in
    1[01][01][01]) echo Erro tipo 8;;&
    [01]1[01][01]) echo Erro tipo 4;;&
    [01][01]1[01]) echo Erro tipo 2;;&
    [01][01][01]1) echo Erro tipo 1;;&
             0000) echo Não há erro;;&
	        *) echo Binário final: $Bin
esac
