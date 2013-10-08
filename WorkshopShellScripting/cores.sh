#!/bin/sh
#  cores.sh - mostra todas as cores do console
#+ usando escapes sequences

for letra in 0 1 2 3 4 5 6 7; do
  for bold in '' ';1'; do
    for fundo in 0 1 2 3 4 5 6 7; do
      seq="4$fundo;3$letra"
      echo "\033[$seq${bold}m $seq${bold:-  } \033[m\c"
    done; echo
  done
done
