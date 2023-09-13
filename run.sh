#!/bin/bash
apt update -y
apt install -y software-properties-common
add-apt-repository universe
apt update -y
apt install -y apache2 php stress unzip
systemctl enable apache2
systemctl start apache2
cd /var/www/html
wget https://github.com/jlcloudtea/webstresstest/blob/main/vm-stress.zip
unzip vm-stress.zip

echo 'UserData has been successfully executed. ' >> ~/result
find -wholename /root/.*history -wholename /home/*/.*history -exec rm -f {} \;
find / -name 'authorized_keys' -exec rm -f {} \;
rm -rf /var/lib/cloud/data/scripts/*

