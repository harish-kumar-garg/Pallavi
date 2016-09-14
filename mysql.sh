#!/bin/bash

mysqlPassword=$1
sudo apt-get update
#no password prompt while installing mysql server
#export DEBIAN_FRONTEND=noninteractive

#another way of installing mysql server in a Non-Interactive mode
echo "mysql-server-5.6 mysql-server/root_password password $mysqlPassword" | sudo debconf-set-selections 
echo "mysql-server-5.6 mysql-server/root_password_again password $mysqlPassword" | sudo debconf-set-selections 

#install mysql-server 5.6
sudo apt-get -y install mysql-server-5.6

#set the password
#sudo mysqladmin -u root password "$mysqlPassword"   #without -p means here the initial password is empty

#alternative update mysql root password method
#sudo mysql -u root -e "set password for 'root'@'localhost' = PASSWORD('$mysqlPassword')"
#without -p here means the initial password is empty

#sudo service mysql restart


cd
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
apt-get update
apt-get install -y mongodb-org=3.2.8 mongodb-org-server=3.2.8 mongodb-org-shell=3.2.8 mongodb-org-mongos=3.2.8 mongodb-org-tools=3.2.8
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-org-shell hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections
service mongod start
