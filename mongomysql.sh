# Configure mongodb.list file with the correct location
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list

# Disable THP
sudo echo never > /sys/kernel/mm/transparent_hugepage/enabled
sudo echo never > /sys/kernel/mm/transparent_hugepage/defrag
sudo grep -q -F 'transparent_hugepage=never' /etc/default/grub || echo 'transparent_hugepage=never' >> /etc/default/grub

# Install updates
sudo apt-get -y update

# Modified tcp keepalive according to https://docs.mongodb.org/ecosystem/platforms/windows-azure/
sudo bash -c "sudo echo net.ipv4.tcp_keepalive_time = 120 >> /etc/sysctl.conf"

#Install Mongo DB
sudo apt-get install -y mongodb-org

# Uncomment this to bind to all ip addresses
# sudo sed -i -e 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/g' /etc/mongod.conf
# sudo service mongod restart




#!/bin/bash

mysqlPassword="Welcome123"
sudo apt-get update
#no password prompt while installing mysql server
#export DEBIAN_FRONTEND=noninteractive

#another way of installing mysql server in a Non-Interactive mode
echo "mysql-server-5.6 mysql-server/root_password password Welcome123" | sudo debconf-set-selections 
echo "mysql-server-5.6 mysql-server/root_password_again password Welcome123" | sudo debconf-set-selections 
sudo apt-get install mysql-server
sudo mysql_secure_installation 
#install mysql-server 5.6

#set the password
sudo mysqladmin -u root password Welcome123   #without -p means here the initial password is empty

#alternative update mysql root password method
sudo mysql -u root -e "set password for 'root'@'localhost' = PASSWORD('Welcome123')"
#without -p here means the initial password is empty

sudo service mysql restart
