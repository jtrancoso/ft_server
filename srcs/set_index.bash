#!/usr/bin/env bash

if [ -z $1 ]
then	
echo "Argument was not provided."
elif [ $1 == on ]
then
sed -i 's/	autoindex off;/	autoindex on;/g' /etc/nginx/sites-available/nginx-wp-conf
echo "Autoindex $(tput setaf 2)ON$(tput sgr 0)"
service nginx restart
elif [ $1 == off ]
then
sed -i 's/	autoindex on;/	autoindex off;/g' /etc/nginx/sites-available/nginx-wp-conf
echo "Autoindex $(tput setaf 1)OFF$(tput sgr 0)"
service nginx restart
fi
