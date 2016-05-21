#!/usr/bin/env bash

sudo yum install -y vim

# Install Rundeck and dependencies.
sudo yum install -y java-1.7.0
sudo rpm -Uvh http://repo.rundeck.org/latest.rpm
sudo yum install -y rundeck
sudo service rundeckd start

# Hosts file for vagrant user.
sudo cp /vagrant/config/hosts/hosts /etc/hosts
