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


echo "Installing webserver on ubuntu"
echo "Install Apach"
apt-get install apache2
echo "Install MySql"
apt-get install mysql-server

echo "Install Phpmyadmin "
apt-get install phpmyadmin 
ln -s /usr/share/phpmyadmin/ /var/www/html/phpmyadmin

echo "Install PHP"
apt-get install php5 libapache2-mod-php5

echo "Restarting Server "

/etc/init.d/apache2 restart

echo "Open a web browser and navigate to http://localhost/. You should see a message saying It works!"

echo "Check PHP "
php -r 'echo "\n\nYour PHP installation is working fine.\n\n\n";'