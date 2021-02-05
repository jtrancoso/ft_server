# set the base image as Debian Buster
FROM debian:buster
# install all services needed
RUN apt-get update && \
	apt-get install -y vim && \
	apt-get install -y nginx && \
	apt-get install -y mariadb-server mariadb-client && \
	apt-get -y install php-cli php-fpm php-json php-pdo php-mysql php-zip php-gd php-mbstring php-curl php-xml php-pear php-bcmath
# install wp and wp cli 
RUN apt-get install wget && \
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	wp core download --path=var/www/wordpress --allow-root
# move things
COPY srcs/index.html var/www/html/
COPY srcs/nginx-wp-conf /etc/nginx/sites-available/
# make links for nginx config
RUN ln -s /etc/nginx/sites-available/nginx-wp-conf /etc/nginx/sites-enabled/
# install phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz && \
	tar -zxvf phpMyAdmin-5.0.4-all-languages.tar.gz && \
	rm -rf phpMyAdmin-5.0.4-all-languages.tar.gz && \
	mv phpMyAdmin-5.0.4-all-languages /var/www/phpMyAdmin && \
	chown -R www-data:www-data /var/www
# executes services
CMD service nginx start && \
	bash