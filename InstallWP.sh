wordpress=latest-fr_FR.zip
echo "les identifiant pour la base associée à wordpress qui sera crée : veuillez les changer"
nom_admin=admin
pass_admin=monpass

sudo apt-get install  apache2 libapache2-mod-php5 php5 php5-gd php5-mysql libphp-phpmailer php5-gd libjs-prototype libjs-scriptaculous tinymce libphp-snoopy libjs-jquery php-gettext libjs-cropper mysql-server mysql-client mysql-admin

cd ~/Téléchargements

echo "création du script sql"
echo "CREATE DATABASE wordpress; CREATE USER $nom_admin; SET PASSWORD FOR $nom_admin = PASSWORD('$pass_admin'); GRANT ALL PRIVILEGES ON wordpress.* TO $nom_admin@localhost IDENTIFIED BY '$pass_admin'; exit; " > wordpress.sql

echo "creation de la base"
mysql -h localhost -u root -p <  ~/Téléchargements/wordpress.sql

wget http://fr.wordpress.org/$wordpress

sudo mkdir /var/www/wordpress

unzip -o $wordpress

cd wordpress
sudo cp -r * /var/www/wordpress


sudo chown -R www-data /var/www/wordpress

firefox http://localhost/wordpress
