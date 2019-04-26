#!/bin/bash
#Author : kamel eddine Heraguemi 
MACHINE_TYPE=`uname -m`



# Checks that the script is running as root, if not
# it will ask for permissions
# Source: http://unix.stackexchange.com/a/28796
if (($EUID != 0)); then
  if [[ -t 1 ]]; then
		sudo "$0" "$@"
	else
		exec 1>output_file
		gksu "$0 $@"
	fi
 
	exit
fi



echo "Google chrome browser"

cd /tmp


if [ ${MACHINE_TYPE} == 'x86_64' ]; then
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb -O chrome.deb
else
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb
fi


	


echo "Installing Google chrome"
dpkg --install chrome.deb

echo "google chrome has been installed"
