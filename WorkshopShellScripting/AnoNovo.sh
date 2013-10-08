#!/bin/bash
#
# Brincadeira de Ano Novo
# Autor: Julio Neves
#
trap 'tput cnorm; tput sgr0; clear; exit' 0 2 3 15
Feliz[1]="FFFFFFF  EEEEEEE  LLL      III  ZZZZZZZ               22222     0000      1111     33333  "
Feliz[2]="FFFFFFF  EEEEEEE  LLL      III  ZZZZZZZ              2222222   000000    11111    333 333 "
Feliz[3]="FFF      EEE      LLL      III      ZZZ              22  222  000  000  11 111   33    333"
Feliz[4]="FFFFF    EEEEE    LLL      III     ZZZ                  222   000  000     111       333  "
Feliz[5]="FFFFF    EEEEE    LLL      III    ZZZ                  222    000  000     111       333  "
Feliz[6]="FFF      EEE      LLL      III   ZZZ                  222     000  000     111   33    333"
Feliz[7]="FFF      EEEEEEE  LLLLLLL  III  ZZZZZZZ              2222222   000000    1111111  333 333 "
Feliz[8]="FFF      EEEEEEE  LLLLLLL  III  ZZZZZZZ              2222222    0000     1111111   33333  "
LargTela=$(tput cols)
while ((${#Feliz[1]}>=LargTela))
do
    zenity --error --title "Feliz Natal" --text "Esta arte ascii ;) precisa de uma tela com uma largura mínima de <big><b>${#Feliz[1]}</b></big> caracteres" || exit 1
    LargTela=$(tput cols)
done

ColCab=$((($(tput cols)-${#Feliz[1]})/2))
Cor=6

function ApagaAcende
{
    tput cup $[Lin - 4] $[Meio + 1]
    ((n == 0)) && {
		echo "TIM  TIM"
		n=1
		return
	}
	tput el
	n=0
}
function Cab
{
	Cor=$[Cor == 7?0:++Cor]
	tput setaf $Cor; tput bold
    for ((kk=1; kk<9; kk++))
    {
	    tput cup $((kk-1)) $ColCab
        echo "${Feliz[kk]}"
    }
    tput setaf 3
}
function FazBolha
{
    for k in 1 2 
    do
    	y=0
        for Sai in 2 4 6 6 
        do  
            C1=$[Sai == 2?$[Meio + 1]:$[Sai == 4?Meio - 0:Meio - 1]]
            C2=$[Sai == 2?$[Meio + 7]:$[Sai == 4?Meio + 6:Meio + 5]]
    		Var=
            for ((j=1; j<=Sai; j++))
            {   
                Var=$Var$[RANDOM % 2]" "
            }   
            x=0 
	    	let y++
            for SN in $Var
            do  
                ((SN)) && {
                    tput cup $[Lin + 2 - y] $[k == 1?C1 + x:C2 + x]
                    echo .
                }   
    			let x++
            done
        done
    done
}
Cols=5
Fim=$(tput cols)
while ((Fim < 96))
do
    tput flash
	zenity --error --text "Ponha o terminal em\nModo de tela cheia" || exit 1
    Fim=$(tput cols)
done
Meio=$[Fim / 2 - 5]
Lin=$[$(tput lines) - 7]
tput civis
tput setab 1
tput bold
tput setaf 3
clear

for ((i=1; i<$Meio; i++))
do

    tput cup $Lin $[i - 1]; echo '      '
    tput cup $[Lin + 1] $[i - 1]; echo '     '
    tput cup $[Lin + 2] $[i - 1]; echo '    '
    tput cup $[Lin + 3] $[i - 1]; echo '    '
    tput cup $[Lin + 4] $[i - 1]; echo '    '
    tput cup $[Lin + 5] $[i - 1]; echo '     '
    tput cup $Lin $i; echo '\____/'
    tput cup $[Lin + 1] $i; echo ' \  /'
    tput cup $[Lin + 2] $i; echo '  \/'
    tput cup $[Lin + 3] $i; echo '  ||'
    tput cup $[Lin + 4] $i; echo '  ||'
    tput cup $[Lin + 5] $i; echo ' (__)'
    tput cup $Lin $[Fim - i - 5]; echo '      '
    tput cup $[Lin + 1] $[Fim - i - 5]; echo '     '
    tput cup $[Lin + 2] $[Fim - i - 5]; echo '    '
    tput cup $[Lin + 3] $[Fim - i - 5]; echo '    '
    tput cup $[Lin + 4] $[Fim - i - 5]; echo '    '
    tput cup $[Lin + 5] $[Fim - i - 5]; echo '     '
    tput cup $Lin $[Fim - i - 6]; echo '\____/'
    tput cup $[Lin + 1] $[Fim - i - 6]; echo ' \  /'
    tput cup $[Lin + 2] $[Fim - i - 6]; echo '  \/'
    tput cup $[Lin + 3] $[Fim - i - 6]; echo '  ||'
    tput cup $[Lin + 4] $[Fim - i - 6]; echo '  ||'
    tput cup $[Lin + 5] $[Fim - i - 6]; echo ' (__)'
	Cab
done
for ((f=0; f<5; f++))
{
    tput flash
	sleep 0.02
}
while true
do
    ((++Conta % 6)) || ApagaAcende
    FazBolha
	Cab
	sleep 0.05
    y=0
	for Sai in 2 4 6 6
	do
		let y++
	    C1=$[Sai == 2?$[Meio + 1]:$[Sai == 4?Meio - 0:Meio - 1]]
	    C2=$[Sai == 2?$[Meio + 7]:$[Sai == 4?Meio + 6:Meio + 5]]
	    for ((j=1; j<=Sai; j++))
	    {   
	        Trab="$Trab"$(((Sai == 4)) && echo -n _ || echo -n ' ')
	    }
	    tput cup $[Lin + 2 - y] $C1
	    echo "$Trab"
	    tput cup $[Lin + 2 - y] $C2
	    echo "$Trab"
		Trab=
	done
	Cab
	sleep 0.05
done
