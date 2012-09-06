#!/bin/bash

dialog --msgbox "Script para limpeza do histórico de documentos recentes." 7 60
dialog --yesno "Deseja limpar histórico de documentos recentes?" 7 50
if [ $? = "0" ]; then
	rm -f ~/.local/share/recently-used.xbel
	sudo touch ~/.local/share/recently-used.xbel
	sudo chmod 400 ~/.local/share/recently-used.xbel
	sudo chattr +i ~/.local/share/recently-used.xbel
	rm -f ~/.local/share/zeitgeist/activity.sqlite
	dialog --msgbox "O histórico será limpo após encerrar esta sessão." 7 70
else
	dialog --msgbox "Sainda sem fazer nada..." 7 50
fi
dialog --yesno "Deseja interromper o programa de gravação do histórico?" 7 70
if [ $? = "0" ]; then
	ps -ax | grep zeitgeist-datahub > /tmp/meu_script
	grep ? /tmp/meu_script > /tmp/meu_script2
	cut -d" " -f2 /tmp/meu_script2 > /tmp/meu_script3
	dialog --msgbox "Ok, matando o processo: `cat /tmp/meu_script3`" 7 70
	kill `cat /tmp/meu_script3`
else
	dialog --msgbox "Ok, execute o script ao final da seção para limpar o histórico." 7 70
fi
rm -f /tmp/meu_scrip*
