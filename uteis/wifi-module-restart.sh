#!/bin/bash
# Restart module iwlwifi
#
# Requires root privilegies
#
################################################################################
#
# Author: Kenner Kliemann , kenner.hp@gmail.com
#
# Out 2013
################################################################################

function remove  {
  modprobe -rv iwldvm
}

function up  {
  modprobe -v iwlwifi
}

echo -e "Removing module iwldvm"
remove
echo -e "Up modules"
up

