#!/bin/bash
#  Se o nome do arquivo tiver pelo menos uma
#+ letra maiúscula, troca-a para minúscula

for Arq in *[A-Z]*
do
    if  [ -f "${Arq,,}" ]
    then
        echo ${Arq,,} já existe
else
    mv "$Arq" "${Arq,,}"
    fi
done
