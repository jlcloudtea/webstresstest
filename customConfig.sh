#!/bin/bash

# Update the system
apt update -y

# Install software-properties-common
apt install -y software-properties-common

# Add universe repository
add-apt-repository universe

# Install apache2, php, stress, and unzip
apt install -y apache2 php stress unzip

# Enable apache2 service
systemctl enable apache2

# Start apache2 service
systemctl start apache2

# Change directory to /var/www/html
cd /var/www/html

# Download vm-stress.zip from GitHub
wget https://github.com/jlcloudtea/webstresstest/raw/main/vm-stress.zip

# Unzip the downloaded file
unzip vm-stress.zip
