#!/usr/bin/env bash

# Copy .bashrc files.
cp /vagrant/config/bash/vagrant.bashrc /home/vagrant/.bashrc
cp /vagrant/config/bash/root.bashrc /root/.bashrc
chown vagrant: /home/vagrant/.bashrc

# Add EPEL and webtatic repos.
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm

# Install vim, git, etc.
yum install -y vim-enhanced bash-completion git yum-utils

# Install PHP7.
yum install -y php70w php70w-cli php70w-fpm php70w-common php70w-devel php70w-gd php70w-mbstring php70w-mcrypt php70w-mysqlnd php70w-pdo php70w-pear php70w-pecl-xdebug php70w-xml

# Install MySQL 5.6.
yum install -y http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
yum-config-manager --disable mysql56-community
yum-config-manager --enable mysql57-community-dmr
yum install -y mysql-community-server-5.7.13

# Configure MySQL 5.6.
mkdir /var/log/mysql
chmod 0755 /var/log/mysql
chown mysql: /var/log/mysql
mysqld --initialize-insecure
chown -R mysql: /var/lib/mysql
cp /vagrant/config/mysql/my.cnf /etc/my.cnf
chmod 0644 /etc/my.cnf
chown mysql: /etc/my.cnf
service mysqld start
chkconfig mysqld on

MYSQL_ROOT_PASSWORD=password

if [ ! -f /var/lib/mysql/.mysql-root-password-has-been-created ]; then
    # Create the mysql root user password.
    mysqladmin -u root password ${MYSQL_ROOT_PASSWORD}
    touch /var/lib/mysql/.mysql-root-password-has-been-created
fi

# Set .my.cnf for root and vagrant users.
cp /vagrant/config/mysql/.my.cnf /root/.my.cnf
cp /vagrant/config/mysql/.my.cnf /home/vagrant/.my.cnf
chmod 0600 /root/.my.cnf
chmod 0600 /home/vagrant/.my.cnf
chown vagrant: /home/vagrant/.my.cnf

# Ensure root user login from 127.0.0.1 works.
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1' identified by '$MYSQL_ROOT_PASSWORD';"

service mysqld restart
