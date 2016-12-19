#!/usr/bin/env bash

# Install Rundeck and dependencies.
yum install -y java-1.7.0
rpm -Uvh http://repo.rundeck.org/latest.rpm
yum install -y rundeck
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
