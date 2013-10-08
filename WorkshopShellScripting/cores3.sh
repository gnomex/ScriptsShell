#!/bin/bash
#  cores3.sh - Lista as cores da console com bold

clear
for Modo in sgr0 bold
{
    echo Em modo $([ $Modo = sgr0 ] && echo Normal || echo Bold)
    eval tput $Modo
    for ((Cor=0; Cor <=7; Cor++))
    {
        tput setf $Cor
        eval printf '%"$(($(tput cols)+1))"s' | tr ' ' '█'
    }
    tput sgr0
}
