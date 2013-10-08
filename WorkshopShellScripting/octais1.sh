#!/bin/sh
#
# Lista os caracteres entre \0000 e \0377 gerados pelo echo no octal correspondente
# Caso receba a opcao -tn, para n variando de 1 a 9 a listagem serah temporizada
#

tp=0
[ `echo "$1" | sed -n '/^-[tT][1-9]$/p'` ]    &&   tp=`expr substr $1 3 1 \* 20`

[ $tp -eq 0 -a $# -gt 0 ] &&
    {
    echo "Uso $0 [-tn] onde n \0351 um temporizador entre 1 e 9"
    exit 1
    }

for i in 0 1 2 3
do
    for j in 0 1 2 3 4 5 6 7
    do
        for k in 0 1 2 3 4 5 6 7
        do
            echo "0$i$j$k=\0$i$j$k\t\c"
            tp1=0
            while [ $tp1 -lt $tp ]
            do
                tp1=`expr $tp1 + 1`
            done
            [ $k -eq 7 ] && echo 
        done
    done
done
