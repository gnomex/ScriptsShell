#!/bin/sh
# Transforma arquivos com nomes em MAIUSCULAS para minusculas
#
# Testando se vc passou o diretorio como parametro
# default = diretorio corrente.

if  [ $# -eq 1 ]
then
    Dir=$1
else
    Dir="."
fi
cd $Dir

for ArqMai in `ls | grep '^[A-Z].*$'`
do
        # Da forma que eu coloquei acima todos os arquivos
        # cujos nomes fossem formados somente por maiusculas.
        # Se vc quiser carac especiais tb, como _  ou . fa(ss)a:
        # for ArqMai in `ls | grep '^[^a-z].*$'`
    ArqMin=`echo $ArqMai | tr "[A-Z]" "[a-z]"`
    if  [ -f "$ArqMin" ] #Existe minusculo?
    then
# listando os 2 em ordem cronologica (-t) e
# pegando o + novo (head -1). Se for o Maiusculo...
        [ `ls -t $ArqMai $ArqMin | head -1` -eq $ArqMai ] && mv -f $ArqMai $ArqMin
    fi
done
