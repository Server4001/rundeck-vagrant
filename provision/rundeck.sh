#!/usr/bin/env bash

# Install Rundeck and dependencies.
yum install -y java-1.7.0
rpm -Uvh http://repo.rundeck.org/latest.rpm
yum install -y rundeck

# Configure Rundeck.
cp /vagrant/config/rundeck/framework.properties /etc/rundeck/framework.properties
cp /vagrant/config/rundeck/rundeck-config.properties /etc/rundeck/rundeck-config.properties
chown rundeck: /etc/rundeck/{framework.properties,rundeck-config.properties}
chmod 0640 /etc/rundeck/{framework.properties,rundeck-config.properties}
service rundeckd start
chkconfig rundeckd on

# Add EPEL repo.
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm

# Install other packages.
yum install -y vim-enhanced bash-completion

# Hosts file.
cp /vagrant/config/hosts/hosts.rundeck /etc/hosts

# Copy .bashrc files.
cp /vagrant/config/bash/vagrant.bashrc /home/vagrant/.bashrc
cp /vagrant/config/bash/root.bashrc /root/.bashrc
chown vagrant: /home/vagrant/.bashrc

# Can login to rundeck at: dev.rundeck.loc:4440 with either user:user or admin:admin.
