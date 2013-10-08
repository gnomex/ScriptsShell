#!/bin/sh
sed -n "
# Se linha vazia, vá pesquisar cadeia
/^$/ b PesqCad
# Senão, acrescenta a linha ao hold buffer
H
# Fim de arquivo também é fim de parágrafo
$ b PesqCad
# Vai para o fim para saltar PesqCad
b
# É aqui que vamos procurar a cadeia no parágrafo
:PesqCad
# Manda todo o parágrafo para o pattern space
x
# Procura a cadeia, se achar imprime
/$1/ p
" $2
