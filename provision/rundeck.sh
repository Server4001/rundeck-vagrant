#!/usr/bin/env bash

rundeck_home=/var/lib/rundeck
rundeck_configs=/vagrant/config/rundeck

# Disable unused services.
service nginx stop
service php-fpm stop
service beanstalkd stop
service memcached stop
service redis stop

# Create the rundeck MySQL database.
mysql -u root -ppassword -e "CREATE DATABASE IF NOT EXISTS rundeckdb CHARACTER SET = 'utf8' COLLATE = 'utf8_general_ci';" 2> /dev/null
mysql -u root -ppassword -e "CREATE USER 'rundeckdb'@'localhost' IDENTIFIED BY 'password';" 2> /dev/null
mysql -u root -ppassword -e "GRANT ALTER, ALTER ROUTINE, CREATE, CREATE ROUTINE, CREATE TEMPORARY TABLES, CREATE VIEW, DELETE, DROP, EVENT, EXECUTE, INDEX, INSERT, LOCK TABLES, REFERENCES, SELECT, SHOW VIEW, TRIGGER, UPDATE on rundeckdb.* TO 'rundeckdb'@'localhost';" 2> /dev/null
mysql -u root -ppassword -e "CREATE USER 'rundeckdb'@'127.0.0.1' IDENTIFIED BY 'password';" 2> /dev/null
mysql -u root -ppassword -e "GRANT ALTER, ALTER ROUTINE, CREATE, CREATE ROUTINE, CREATE TEMPORARY TABLES, CREATE VIEW, DELETE, DROP, EVENT, EXECUTE, INDEX, INSERT, LOCK TABLES, REFERENCES, SELECT, SHOW VIEW, TRIGGER, UPDATE on rundeckdb.* TO 'rundeckdb'@'127.0.0.1';" 2> /dev/null

# Install Rundeck and dependencies.
yum install -y java-1.7.0
rpm -Uvh http://repo.rundeck.org/latest.rpm
yum install -y rundeck-2.6.1 rundeck-config-2.6.1

# Configure Rundeck.
mkdir -p ${rundeck_home}/var/storage/content/keys
cp ${rundeck_configs}/framework.properties /etc/rundeck/framework.properties
cp ${rundeck_configs}/rundeck-config.properties /etc/rundeck/rundeck-config.properties
cp ${rundeck_configs}/profile /etc/rundeck/profile
cp ${rundeck_configs}/ssh/{id_rsa,id_rsa.pub} ${rundeck_home}/.ssh
cp ${rundeck_configs}/ssh/rundeck.pem ${rundeck_home}/var/storage/content/keys/rundeck.pem
chown rundeck: /etc/rundeck/{framework.properties,rundeck-config.properties,profile}
chown -R rundeck: ${rundeck_home}/.ssh
chmod 0640 /etc/rundeck/{framework.properties,rundeck-config.properties,profile}
chmod 0600 ${rundeck_home}/.ssh/id_rsa
chmod 0644 ${rundeck_home}/.ssh/id_rsa.pub
chown -R rundeck: ${rundeck_home}/var/storage
chmod -R 0775 ${rundeck_home}/var/storage
chmod 0600 ${rundeck_home}/var/storage/content/keys/rundeck.pem
service rundeckd start
chkconfig rundeckd on

# Set up the WebServer project for Rundeck.
mkdir -p /var/rundeck/projects/WebServer/{acls,etc}
cp ${rundeck_configs}/projects/WebServer/{resources.xml,project.properties} /var/rundeck/projects/WebServer/etc
chown -R rundeck: /var/rundeck/projects

# Hosts file.
cp /vagrant/config/hosts/hosts.rundeck /etc/hosts

# Copy .bashrc files.
cp /vagrant/config/bash/vagrant.bashrc /home/vagrant/.bashrc
cp /vagrant/config/bash/root.bashrc /root/.bashrc
chown vagrant: /home/vagrant/.bashrc

# Can login to rundeck at: dev.rundeck.loc:4440 with either user:user or admin:admin.
