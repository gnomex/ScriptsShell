Maquina=""
SN=""
OL=""
function Erro
{
    Len=`expr length "$1"`
    C=`expr "(" 80 - "$Len" ")" / 2`
    tput cup 21 $C
    echo "$1\07\c"
    read a < /dev/tty
    tput cup 21 1
    echo "                                                                              "
    return
}

function Pergunta
{
    DefVal=`echo "$2" | tr "[a-z]" "[A-Z]"`
    OthVal=`echo "$3" | tr "[a-z]" "[A-Z]"`
    Quest=`echo "${1}? ${DefVal}//"`
    Len=`expr length "$Quest"`
    Col=`expr \( \`tput cols\` - "$Len" ")" / 2`
    tput cup `expr \`tput lines\` - 2` $Col
    echo "$Quest\07\c"
    read SN < /dev/tty
    
    SN=${SN:-"$DefVal"}

    SN=`echo $SN | tr "[a-z]" "[A-Z]"`
    if  [ "$SN" != "$OthVal" ]
    then
        SN="$DefVal"
    fi
    
    tput cup `expr \`tput lines\` - 2` 1
    tput el
    return
}

#!/bin/bash
#
#==========================================================
# Recebe uma qtd de dias como parametro, e o transforma em
# uma data, que significa 1/1/1980 + parametro recebido.
# Obs. Para executar este programa sob o sh, trocar por
# $((..)) por expr
#==========================================================
# Leia: Linux - Programacao Shell  ISBN: 85-7452-048-9
# Autor: Julio Cezar Neves <mailto:julio.neves@writeme.com>
#==========================================================
#
Num=$(($1 - 1))
AFim=$((1980 + (Num / 365)))
DFim=$((Num % 365 - Num / 1460))
MFim=1
for i in 31 28 31 30 31 30 31 31 30 31 30 31
do
    [ $DFim -lt $i ] && break
    DFim=$((DFim - i))
    MFim=$((MFim + 1))
done
[ $DFim -eq 0 ] &&
{
    DFim=29
    MFim=2
}
[ $DFim -le 9 ] && echo "0$DFim/\c" || echo "$DFim/\c"
[ $MFim -le 9 ] && echo "0$MFim/\c" || echo "$MFim/\c"
echo $AFim

#!/bin/bash
#
#======================================================================
# Calcula qtd dias entre uma data passada como parametro e 01/01/1980.
# Se nao for passado nenhum parametro a data de hoje sera assumida.
# Obs. Para executar este programa sob o sh, trocar os $((..)) por expr
#======================================================================
# Leia: Linux - Programacao Shell  ISBN: 85-7452-048-9
# Autor: Julio Cezar Neves <mailto:julio.neves@writeme.com>
#======================================================================
#
if  [ $1 ]
then
    DFim=`echo $1 | cut -f1 -d"/"`
    MFim=`echo $1 | cut -f2 -d"/"`
    AFim=`echo $1 | cut -f3 -d"/"`
else
    DFim=`date +%d`
    MFim=`date +%m`
    AFim=`date +%Y`
fi

TotDias=$((1 + 365 * (AFim - 1980) + (AFim - 1980) / 4))
[ $((AFim % 4)) = 0 -a $MFim -le 2 ] && TotDias=$((TotDias - 1))

for i in `echo "31 28 31 30 31 30 31 31 30 31 30 31" | cut -f-$((MFim - 1)) -d" " 2> /dev/null`
do
    TotDias=$((TotDias + $i))
done
echo $((TotDias + DFim))

Limpa ( )

{
    tput cup 21 1
    echo "                                                                              "
    return
}

Mostra ( )

{
    Mostra=$*
    Limpa 
    Len=`expr length "$Mostra"`
    Col=`expr "(" 80 - "$Len" ")" / 2`
    tput cup 21 $Col
    echo "$Mostra"
}


function Cab
{
clear
echo "
    +------------+------------+--------------------------------------------+
    |            |            |                                            |
    |  DATAPREV  |  TRANSFTP  |                     Producao RJ (821)2347  |
    |            |            |  Suporte (821)2338           SP (811)6200  |
    +------------+------------+--------------------------------------------+"
}

function Div    #  Faz divisao de inteiros dando resultado com $3 decimais
{
    Divid=$1
    Divis=$2
    Decim=$3
    Resp=`expr $Divid / $Divis`,
    while [ "$Decim" -gt 0 ]
    do
        Divid=`expr $Divid % $Divis \* 10`
        Resp=$Resp`expr $Divid / $Divis`
        Decim=`expr $Decim - 1`
    done
    return      #        Quociente editado esta em Resp
}

function ChecaPW
{
    Lin=$(($1\*4+7))

    if  [ "$2" -eq 1 ]
    then
        Site=RJ
        Maquina=durjcv01
    else
        Site=SP
        Maquina=duspmv01
    fi

    j=1            
    while true
    do
        tput cup $Lin $Cwr
        echo "Login Name em $Site ($LOGNAME):                          "
        tput cup $Lin $Cre
        read User
        User=${User:-"$LOGNAME"}
        tput cup $Lin $Cre
        echo $User
        tput cup $(($Lin+2)) $Cwr
        echo "Entre com Password em $Site:"
        tput cup $(($Lin+2)) $Cre
        stty -echo
        read PW
        stty echo
        if  [ -z "$PW" ]
        then
            Pergunta "Deseja continuar" S N
            if  [ "$SN" = N ]
            then
                exit
            fi    
            continue
        fi
        ftp -ivn $Maquina << fimftp > "/tmp/$$"     ##  So para testar a senha...
            user "$User" "$PW"
            quit
fimftp
        if  [ `grep -c "^530 " "/tmp/$$"` -ne 0 ]
        then
            j=`expr $j + 1`
            if  [ "$j" -eq 4 ]     ##  Se em 4 tentativas nao acertar; BYE BYE...
            then
                Erro "Tentativa de violacao. Programa descontinuado."
                rm /tmp/"$$"
                exit
            fi
            Erro "Senha nao confere. Tente outra vez."
            continue
        fi
        break
    done
}

function LeMaq
{
    Lin=$1
    Col=$2
    if  [ "$#" -eq 3 ]
    then
	MaqDef=$3
    fi
    while true
    do
        tput cup $Lin $Col
        echo "                                                                              "
        tput cup $Lin $Col
        read Maquina
        if  [ "$#" -eq 3 ]
	then
            Maquina=${Maquina:-"$MaqDef"}
        fi
        if  [ -z "$Maquina" ]
        then
            SN "Deseja Abandonar" S N
            if  [ "$SN" = N ]
            then
                continue
            fi
            exit
        fi
		
        if  [ `fgrep -c "$Maquina" /etc/hosts` -eq 0 ]
        then
            Erro "Nao existe regional com maquina com este nome"
            continue
        fi
        return
    done
}

function LeOL
{
    Col=$1
    Lin=$2
    OLs="02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 26 28"
    while true
    do
        tput cup $Lin $Col
        echo "                                                                              "
        tput cup $Lin $Col
        read OL
        if  [ -z "$OL" ]
        then
            SN "Deseja Abandonar" S N
	    if  [ "$SN" = N ]
	    then
                continue
            fi
            exit
        fi
		
        if  [ `echo "$Maquina" | fgrep -c "$OLs"` -eq 0 ]
	then
            Erro "Nao existe OL com este numero"
            continue
        fi
        return
    done
}
