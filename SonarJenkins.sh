wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get -y install default-jdk
sudo apt-get -y install jenkins


#!bin/bash
sudo su
cd
wget https://raw.githubusercontent.com/pallaviks/Pallavi/master/mysqlforsonar.sh?_sm_au_=iMV5K7q5HStbDZqH
#installing mysql
sh mysqlforsonar.sh?_sm_au_=iMV5K7q5HStbDZqH
wget https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-5.6.zip
apt-get install -y unzip
unzip sonarqube-5.6.zip
mv sonarqube-5.6 /opt/sonar
ip="$(ifconfig | grep -A 1 'eth0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)"
echo "sonar.jdbc.username=sonar" >> /opt/sonar/conf/sonar.properties
echo "sonar.jdbc.password=sonar" >> /opt/sonar/conf/sonar.properties
echo "sonar.jdbc.url=jdbc:mysql://{$ip}:3306/sonar?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance" >>/opt/sonar/conf/sonar.properties
echo "sonar.web.host=0.0.0.0" >> /opt/sonar/conf/sonar.properties
echo "sonar.web.context=/sonar" >> /opt/sonar/conf/sonar.properties
echo "sonar.web.port=9000" >> /opt/sonar/conf/sonar.properties
cp /opt/sonar/bin/linux-x86-64/sonar.sh /etc/init.d/sonar
echo "SONAR_HOME=/opt/sonar" >> /etc/init.d/sonar
echo "PLATFORM=linux-x86-64" >> /etc/init.d/sonar
echo "WRAPPER_CMD="${SONAR_HOME}/bin/${PLATFORM}/wrapper"" >> /etc/init.d/sonar
echo "WRAPPER_CONF="${SONAR_HOME}/conf/wrapper.conf"" >> /etc/init.d/sonar
echo "PIDDIR="/var/run"" >> /etc/init.d/sonar
update-rc.d -f sonar remove
chmod 755 /etc/init.d/sonar
update-rc.d sonar defaults
/opt/sonar/bin/linux-x86-64/sonar.sh start
