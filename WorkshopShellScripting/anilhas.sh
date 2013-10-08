#!/bin/bash
#  O prg serve para contar a quantidade de cada anilha teria de usar
#+ para fazer uma cabeação.
#+ Anilhas são aqueles pequenos anéis numerados que você vê nos cabos
#+ de rede, que servem para identificá-los.
[[ $# != 2 ]] && {
    echo "Uso: $0 '<Número Inicial>' '<Número Final>'"
    exit 1
    }
Tudo=$(eval echo {$1..$2})          # Recebe os num. entre $1 e $2
Tudo=${Tudo// /}                    # Tira os brancos gerados pelo cmd anterior
echo $Tudo::::${#Tudo}; read
for ((i=0; i<${#Tudo}; i++))
{
    let Algarismo[${Tudo:i:1}]++    # Incrementa vetor do algarismo
}
for ((i=0; i<=9; i++))
{
    printf "Algarismo %d = %2d\n" \
    $i ${Algarismo[$i]:-0}          # Se o elemento for vazio, lista zero
}
