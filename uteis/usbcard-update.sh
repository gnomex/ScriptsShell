#!/bin/bash
#
## usbcard-update.sh
#	atualiza dispositivos usb
#
#	Versão 1: Atualizar dispositivos ubs para reconhecer sdcard
#
#Obs: Necessita de permisão de root
##

echo 'Updating device, needs root permission'
sudo sh -c 'echo 1 > /sys/bus/pci/rescan'

exit 0
