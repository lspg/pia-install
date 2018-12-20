#!/bin/bash

# BASICS : timezon, locales, shell, requirements
dpkg-reconfigure locales tzdata
apt update
apt -y upgrade
apt -y install curl dirmngr sudo git
sed '/export LS_OPTIONS=/s/^# //g' -i ~/.bashrc
sed '/eval "`dircolors`"/s/^# //g' -i ~/.bashrc
sed '/alias ll=/s/^# //g' -i ~/.bashrc
sed '/alias l=/s/^# //g' -i ~/.bashrc
. ~/.bashrc