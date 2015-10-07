#!/bin/sh

# install nginx
sudo apt-get install -y nginx

# update the config
sudo wget https://raw.githubusercontent.com/electronicbits/teamcity-ubuntu/master/nginx.conf -O /etc/nginx/sites-available/teamcity
sudo mkdir -p /var/www/teamcity

# create syn link
sudo ln -s /etc/nginx/sites-available/teamcity /etc/nginx/sites-enabled/teamcity

# reload
sudo /etc/init.d/nginx reload