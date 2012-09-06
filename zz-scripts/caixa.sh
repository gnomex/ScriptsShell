#!/bin/bash
#
#
#
################################################################################
#
# Autor: Kenner Kliemann , kenner.kliemann@itai.org.br
#	
#	Licença: GPL
#	Agosto de 2012
################################################################################

#Configuração do usuario
caixa_largura=40
caixa_coluna_inicio=5
caixa_linha_inicio=5
texto_max_linhas=20
distancia_borda_texto=1
caixa_cor='33;1'
texto_cor='33;43'
caixa_cor='33;43'

#-------------------------------------------------------------------------------


echo "##Configuração dinâmica"
caixa_coluna_fim=$((caixa_coluna_inicio+caixa_largura-1 ))
texto_coluna_inicio=$((caixa_coluna_inicio+distancia_borda_texto+1))
texto_largura=$((	caixa_largura-distancia_borda_texto))
texto=$(	fmt -sw $texto_largura)
num_linhas=$(	echo $texto | wc -l)
total_linhas=$((	num_linhas+2))

echo "##Checagem do tamanho do texto"
if [ $num_linhas -gt $texto_max_linhas]; then
	echo "Texto muito extenso, não vai caber"
	exit 1
fi

echo "##Compoe a linha horizontal da caixa"
for i in $(seq $(( caixa_largura-2))); do
	linha_caixa="$linha_caixa-"
done


##LImpa a tela
echo -ne '\033c'

#Desenha a caixa
echo -ne "\033[$caixa_linha_inicio;OH"	#Pula para linha inicial
echo -ne "\033[${caixa_cor}m"		#liga cor da caixa

for i in $(seq $total_linhas); do
	echo -ne "\033[${caixa_coluna_inicio}G"	#vai p coluna inicial
	
	if [ $i -eq 1 -o $i -eq $total_linhas ]; then
		echo +$linha_caixa+
	else
		echo -e "|\033[${caixa_coluna_fim}G|"
	fi
done
echo -e "\033[m"

##Coloca texto dentro da caixa

echo -ne "\033[$((caixa_linha_inicio+1));OH"
echo -ne "\033[${texto_cor}m"
echo "$texto" | while read LINHA; do
	echo -e "\033[${texto_coluna_inicio}G$LINHA"
done

echo -e '\033[m'
echo

##end
