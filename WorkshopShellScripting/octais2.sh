#! /bin/bash
#
# Lista os caracteres entre \0000 e \0377 gerados pelo echo no octal correspondente
# Caso receba a opcao -tn, para n variando de 1 a 9 a listagem serah temporizada
#

loop1='0 1 2 3' 
loop2='0 1 2 3 4 5 6 7'
set -A array 0 1 2 3 4 5 6 7

echo "     ${array[0]}   ${array[1]}   ${array[2]}   ${array[3]}\
    ${array[4]}   ${array[5]}   ${array[6]}   ${array[7]} "
echo

for i in $loop1
do
  for j in $loop2
  do
   echo "$i$j   \0$i$j${array[0]}   \0$i$j${array[1]}\
   \0$i$j${array[2]}   \0$i$j${array[3]}   \0$i$j${array[4]}\
   \0$i$j${array[5]}   \0$i$j${array[6]}   \0$i$j${array[7]}"
  done
done

echo
echo "     ${array[0]}   ${array[1]}   ${array[2]}   ${array[3]}\
   ${array[4]}   ${array[5]}   ${array[6]}   ${array[7]} "
echo
