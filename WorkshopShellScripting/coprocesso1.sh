#!/bin/bash
coproc { read -u ${COPROC[1]} Entrada; echo Recebi $Entrada; sleep 3; }
# Main
COPROC[1]=fff
read -u ${COPROC[0]} Saida
echo O coprocesso disse: \"$Saida\"
kill $COPROC_PID
