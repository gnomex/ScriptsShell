#!/bin/bash
# Escrito por Leandro Santiago da Silva
# leandrosansilva@gmail.com
# Script escrito por mim em shell script, baseado num programa em c de
Victorine Viviane Mizrahi.
# Depois eu comento direito ele, mas acho que dá para entender bem.
echos_verde()
{
echo -e -n "\033[42;31;1m$*"; echo -ne "\033[m"
}
echos_marrom()
{
echo -e "\033[43;32m$*"; echo -ne "\033[m"
}

echos_borda_esq()
{
echo -e "\033[40;32m$*"; echo -ne "\033[m"
}
echos_borda_dir()
{
echo -e -n "\033[40;32m$*"; echo -ne "\033[m"
}

Natal()
{
clear
for ((i=0;i<altura;i++)) do
for (( k=1; k<5; k++ )) do
for (( j=1; j<= ((40-(2*i+k))) ; j++ )); do echo -n ' '; done
echos_borda_dir '/'
for (( j=1; j< ((2*i+k)) ; j++ )); do echos_verde o; done
for (( j=1;j< ((2*i+k)); j++ )); do echos_verde o ; done
echos_borda_esq \\
done
done

for ((i=0;i<caule;i++)); do
for ((j=0;j<38;j++)); do echo -n ' '; done
echos_marrom '| |';
done

echo
for ((j=0;j<35;j++)); do echo -n ' '; done
echo "FELIZ NATAL"
for ((j=0;j<31;j++)); do echo -n ' '; done
echo "E UM PROSPERO $((($(date +%Y)+1)))"
}
if [ ! -z $1 ] && [ ! -z $2 ]; then
altura=$1
caule=$2
if ((altura<11)) && ((altura>0)) && ((caule<6)) && ((caule>0)); then
Natal
else
echo
echo Uso: natal \<altura_da_arvore\> \<altura_do_caule\>
echo
echo Onde 1 \<\= altura_da_arvore \<\= 10 e 1 \<\=
altura_do_caule \<\= 5
echo
fi
else
altura=6
caule=2
Natal
fi
