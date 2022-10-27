echo 

echo -e "\e[1;32m Step 1: Updating packages \e[0m"
apt-get update

echo

echo -e "\e[1;32m Step 2: Upgrading packages \e[0m" 
apt-get upgrade -y
apt-get dist upgrade -y 
apt-get update
echo 

echo -e "\e[1;32m Step 3: Cleaning up \e[0m"
apt-get clean
apt-get autoclean
apt-get autoremove

echo

echo -e "\e[1;32m Step 4: Installing Apache \e[0m"
apt install  apache2
systemctl enable apache2
ufw allow 'Apache'
service apache2 restart
cat apache.txt

echo

echo -e "\e[1;32m Step 5: Installing Mariadb \e[0m"
apt install mariadb-server
systemctl enable mariadb
systemctl start mariadb.service
cat  mariadbinst.txt
mysql_secure_installation
mariadb 

echo

echo -e "\e[1;32m Step 6: Installing phpMyAdmin \e[0m"
apt-get install php -y
cat  phpinst.txt
apt install phpmyadmin php-mbstring php-zip php-gd php-json php-curl -y

echo

#Granting admin privileges, enable mbstring php ext., and restart Apache
usermod -aG sudo chamberscp
phpenmod mbstring
sudo systemctl restart apache2
mysql

echo

# "\e[1;32m Step 7: Downloading Sakila and importing it to MAriadb \e[0m"
mkdir Documents
cd Documents
curl https://downloads.mysql.com/docs/sakila-db.tar.gz
tar -xvzf community_images.tar.gz -C /home/chambers/Documents/
mysql
SOURCE /home/chambers/Documents/sakila-db/sakila-schema.sql;
SOURCE /home/chambers/Documents/sakila-db/sakila-data.sql


return 2>/dev/null; exit
