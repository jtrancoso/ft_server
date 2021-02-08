#!/usr/bin/bash

wp config create --dbname=wptest --dbuser=jesus --dbpass=1234 --dbhost=localhost --dbprefix=wp_ --allow-root --path=var/www/wordpress && \
wp core install --url=localhost/wordpress --title=Holaquetal --admin_user=jesus --admin_password=1234 --admin_email=jtrancos@student.42madrid.com --skip-email --allow-root --path=var/www/wordpress && \
wp theme install twentyseventeen --activate --allow-root --path=var/www/wordpress