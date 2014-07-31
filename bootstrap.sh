#!/bin/bash

apt-get update

echo "America/Los_Angeles" > /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata

# Install Apache
apt-get install -y apache2 apache2.2-common
apt-get -yf install

# Install PageSpeed
wget -nv https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb
dpkg -i mod-pagespeed-*.deb
apt-get -yf install
rm mod-pagespeed-*.deb

# Enable proxy modules
a2enmod proxy
a2enmod proxy_http

ln -fs /vagrant/conf/*conf /etc/apache2/conf.d/
echo "Include conf.d/proxy_vhost.conf" > /etc/apache2/sites-available/default

service apache2 restart # and go!
