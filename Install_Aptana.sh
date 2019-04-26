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



echo "Downloading Aptana Studio 3"

cd /tmp

if [ ${MACHINE_TYPE} == 'x86_64' ]; then
	wget http://d1iwq2e2xrohf.cloudfront.net/tools/studio/standalone/3.6.0.201407100658/linux/Aptana_Studio_3_Setup_Linux_x86_64_3.6.0.zip -O AptanaStudio.zip
else
	wget http://d1iwq2e2xrohf.cloudfront.net/tools/studio/standalone/3.6.0.201407100658/linux/Aptana_Studio_3_Setup_Linux_x86_64_3.6.0.zip -O AptanaStudio.zip
fi



# Create the /opt dir if it doesn't exist
if [ ! -d /opt/ ]; then
	mkdir /opt/
fi



echo "Extracting Aptana Studio 3 to /opt"

unzip -q AptanaStudio.zip -d /opt/



echo "Adding Aptana Studio 3 desktop entry"

# Create the /usr/local/share/icons dir if it doesn't exist
if [ ! -d /usr/local/share/icons/ ]; then
	mkdir /usr/local/share/icons/
fi

# Fix for large icon problem
cp /opt/Aptana_Studio_3/icon.xpm /usr/local/share/icons/aptanastudio3.xpm

echo "#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Encoding=UTF-8
Name=Aptana Studio 3
GenericName=Integrated Development Environment
Comment=Aptana Strudio 3 Integrated Development Environment
Exec=/opt/Aptana_Studio_3/AptanaStudio3 %F
TryExec=/opt/Aptana_Studio_3/AptanaStudio3
Icon=aptanastudio3
StartupNotify=true
StartupWMClass=\"Aptana Studio 3\"
Terminal=false
Type=Application
MimeType=text/xml;application/xhtml+xml;application/x-javascript;application/x-php;application/x-java;text/x-javascript;text/html;text/plain
Categories=GNOME;Development;IDE;" >> /tmp/SC-AptanaStudio.desktop
xdg-desktop-menu install /tmp/SC-AptanaStudio.desktop

echo "Aptana Studio 3 has been installed"
