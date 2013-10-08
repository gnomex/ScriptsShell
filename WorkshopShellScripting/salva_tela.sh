#!/bin/bash
seq 2000 | xargs                    #  Sujando a tela
Lin=$(($(tput lines) / 2))          #  Calculando linha e coluna centrais da tela
Col=$(($(tput  cols) / 2))
tput cup $Lin; tput el; tput setf 1 #  Posicionando, apagando a linha central e colorindo
echo "Em 10 segundos essa tela será fotografada e se apagará"
tput civis                          # Cursor invisível para melhorar apresentação
for ((i=10; i!=0; i--))
{
    tput cup $Lin $Col; tput el     # Posiciona no centro da tela e limpa núm anterior
    echo $i
    sleep 1
}
tput smcup                          #  Tirando uma foto da tela
clear                               #  Poderia ter usado tput reset
tput cup $Lin
echo "Dentro de 10 segundos a tela inicial será recuperada"
for ((; i<10; i++))
{
    tput cup $Lin $Col              #  Posicionou no centro da tela
    echo $i
    sleep 1
}
tput rmcup                          #  Restaurou a foto
tput cvvis;tput setf 9              #  Restaurou o cursor e cor
