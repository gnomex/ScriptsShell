#!/bin/bash
#
## Encontra versões do kernel instaladas
#
#



echo "Encontrando versões instaladas do kernel"


dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d'

echo
echo "Para remover alguma verão digite o seguinte comando $: apt-get remove --purge linux-[image|headers]-<versão a ser removida>"