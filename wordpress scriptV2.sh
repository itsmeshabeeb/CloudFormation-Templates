# Download wordpress package and extract
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* /var/www/html/

# AUTOMATIC mysql_secure_installation
# change permission of error log file to extract initial root password 
chown  ec2-user:apache /var/log/mysqld.log
temppassword=$(grep 'temporary password' /var/log/mysqld.log | grep -o ".\{12\}$")
chown  mysql:mysql /var/log/mysqld.log


db_root_password=Greenapple@9633
db_username=wordpress_db
db_user_password=Macbook@2022

#change root password to db_root_password
mysql -p$temppassword --connect-expired-password  -e "SET PASSWORD FOR root@localhost = 'Greenapple@9633';FLUSH PRIVILEGES;"
mysql -p'$db_root_password'  -e "DELETE FROM mysql.user WHERE User='';"
mysql -p'$db_root_password' -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"


# Create database user and grant privileges
mysql -u root -p"$db_root_password" -e "GRANT ALL PRIVILEGES ON . TO '$db_username'@'localhost' IDENTIFIED BY '$db_user_password';FLUSH PRIVILEGES;"

# Create database
mysql -u $db_username -p"$db_user_password" -e "CREATE DATABASE $db_name;"

# Create wordpress configuration file and update database value
cd /var/www/html
cp wp-config-sample.php wp-config.php

sed -i "s/database_name_here/$db_name/g" wp-config.php
sed -i "s/username_here/$db_username/g" wp-config.php
sed -i "s/password_here/$db_user_password/g" wp-config.php
cat <<EOF >>/var/www/html/wp-config.php

define( 'FS_METHOD', 'direct' );
define('WP_MEMORY_LIMIT', '256M');
EOF

# Change permission of /var/www/html/
chown -R ec2-user:apache /var/www/html
chmod -R 774 /var/www/html

#  enable .htaccess files in Apache config using sed command
sed -i '/<Directory "\/var\/www\/html">/,/<\/Directory>/ s/AllowOverride None/AllowOverride all/' /etc/httpd/conf/httpd.conf

#Make apache and mysql to autostart and restart apache
systemctl enable  httpd.service
systemctl enable mysqld.service
systemctl restart httpd.service



