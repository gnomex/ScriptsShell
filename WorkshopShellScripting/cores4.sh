#!/bin/bash
#  cores3.sh - Lista as cores da console com bold

clear
for ((Cor=0; Cor <=7; Cor++))
{
    for Modo in sgr0 bold
    {
        tput $Modo
        tput setf $Cor
        eval printf '%-$(tput cols)s\\n' \"-Em-modo-$([ $Modo = sgr0 ] && echo Normal || echo Bold)-\" | tr ' ' '█'
    }
    tput sgr0
}
