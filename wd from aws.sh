#!/bin/bash

# giving root access
sudo -i

yum install -y httpd

systemctl start httpd.service

systemctl enable httpd.service

yum install -y mariadb-server mariadb

systemctl start mariadb

# mysql_secure_installation

systemctl enable mariadb.service

amazon-linux-extras install php7.3

systemctl restart httpd.service

nano /var/www/html/farhan.php

