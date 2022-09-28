#!/bin/bash

MYSQL_ROOT_PASSWORD=abcd1234

SECURE_MYSQL=$(expect -c "
set timeout 2
mysql_secure_installation
expect \"Enter current password for root (enter for none):\"
send \"abcd1234\r\"
expect \"Change the root password?\"
send \"n\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"y\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

echo "$SECURE_MYSQL"

aptitude -y purge expect






#!/bin/bash
 
echo "Enter your name"
expect "Enter your name"
send "shabeeb\n";
 
read $REPLY
 
echo "Enter your age"
expect "Enter your age"
send "22\n";
 
read $REPLY
 
echo "Enter your salary"
expect "Enter your salary"
send "30000\n";
 
read $REPLY
echo "its completed thanks"

