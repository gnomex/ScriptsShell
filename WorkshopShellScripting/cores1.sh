#!/bin/bash
#  cores1.sh - Lista cores de fonte e de fundo
#+ usando setf e setb

for ((b=0; b<=7; b++))
{
    tput setb  9; tput setf  9; echo -n "|"
    for ((f=0; f<=7; f++))
    {
        tput setb $b; tput setf $f; echo -n " b=$b f=$f "
        tput setb  9; tput setf  9; echo -n "|"
    }
    echo
}
tput setb 9; tput setf 9
