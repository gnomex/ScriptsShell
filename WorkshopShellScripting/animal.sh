#!/bin/bash
# Separa animais selvagens e domésticos
declare -A Animais
Animais[cavalo]=doméstico
Animais[zebra]=selvagem
Animais[gato]=doméstico
Animais[tigre]=selvagem
Animais[urso pardo]=selvagem
for Animal in "${!Animais[@]}"
do
    if  [[ "${Animais[$Animal]}" == selvagem ]]
    then
        Sel=("${Sel[@]}" "$Animal")
    else
        Dom=("${Dom[@]}" "$Animal")
    fi
done
Maior=$[${#Dom[@]} > ${#Sel[@]}?${#Dom[@]}:${#Sel[@]}]
clear
tput bold; printf "%-15s%-15s\n" Domésticos Selvagens; tput sgr0
for ((i=0; i<$Maior; i++))
{
    tput cup $[1+i]  0; echo ${Dom[i]}
    tput cup $[1+i] 14; echo ${Sel[i]}
}
