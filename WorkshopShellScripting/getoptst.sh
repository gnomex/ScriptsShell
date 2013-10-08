#!/bin/sh
# Execute assim:
#
#       getoptst.sh  -h  -Pimpressora arq1 arq2
#
# e note que as informacoes de todas as opcoes sao exibidas
#
# A cadeia 'P:h' diz que a opcao -P eh uma opcao complexa
# e requer um argumento, e que h eh uma opcao simples que nao requer
# argumentos.
while getopts 'P:h' OPT_LETRA
do
    echo "getopts fez a variavel OPT_LETRA igual a '$OPT_LETRA'"
    echo "  OPTARG eh '$OPTARG'"
done
used_up=`expr $OPTIND - 1`
echo "Dispensando os primeiros \$OPTIND-1 = $used_up argumentos"
shift $used_up
echo "O que sobrou da linha de comandos foi '$*'"
