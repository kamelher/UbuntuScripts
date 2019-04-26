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



echo "Eclipse IDE for Java EE Developers"

cd /tmp


if [ ${MACHINE_TYPE} == 'x86_64' ]; then
	wget http://mirror.ufs.ac.za/eclipse/technology/epp/downloads/release/luna/SR2/eclipse-java-luna-SR2-linux-gtk.tar.gz -O Eclipse.tar.gz
else
	wget http://mirror.ufs.ac.za/eclipse/technology/epp/downloads/release/luna/SR2/eclipse-java-luna-SR2-linux-gtk-x86_64.tar.gz -O Eclipse.tar.gz
fi


	


echo "Eclipse IDE for Java EE Developers to /opt"

tar -xvzf Eclipse.tar.gz
mv eclipse /opt/eclipse

echo "Eclipse IDE for Java EE Developers desktop entry"

# Create the /usr/local/share/icons dir if it doesn't exist
if [ ! -d /usr/local/share/icons/ ]; then
	mkdir /usr/local/share/icons/
fi

# Fix for large icon problem
cp /opt/eclipse/icon.xpm /usr/local/share/icons/eclipse.xpm

echo "#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Encoding=UTF-8
Name=eclipse
GenericName=Integrated Development Environment
Comment=eclipse  Integrated Development Environment
Exec=/opt/eclipse/eclipse %F
TryExec=/opt/eclipse/eclipse
Icon=eclipse
StartupNotify=true
StartupWMClass=\"Eclipse\"
Terminal=false
Type=Application
Categories=GNOME;Development;IDE;" >> /tmp/SC-eclipse.desktop
xdg-desktop-menu install /tmp/SC-eclipse.desktop
echo "Aptana Studio 3 has been installed"
