#!/usr/bin/bash

mysql -uroot <<MYSQL_SCRIPT
CREATE DATABASE wptest;
CREATE USER 'jesus'@'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON wptest.* TO 'jesus'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

echo "MySQL user created."