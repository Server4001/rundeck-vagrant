#!/usr/bin/env bash

# Add Rundeck's SSH key to authorized keys file.
echo "" >> /home/vagrant/.ssh/authorized_keys
cat /vagrant/config/rundeck/ssh/rundeck.pub >> /home/vagrant/.ssh/authorized_keys

# Copy of index.php.
cp /vagrant/config/nginx/index.php /var/www/html/index.php
chown -R nginx: /var/www/html
