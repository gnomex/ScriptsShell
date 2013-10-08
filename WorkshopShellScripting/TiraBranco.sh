#!/bin/bash
#  Renomeia arquivos com espaços nem branco
#+ no nome, trocando-os por sublinhado (_).

Erro=0
for Arq in *' '*
do
    [ -f ${Arq// /_} ] && {
        echo $Arq não foi renomeado
	Erro=1
	continue
	}
    mv "$Arq" "${Arq// /_}"
done 2> /dev/null
exit $Erro
