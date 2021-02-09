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
COPY srcs/index.html var/www/
COPY srcs/nginx-wp-conf /etc/nginx/sites-available/
COPY srcs/create_DB.bash /
COPY srcs/create_wp.bash /
COPY srcs/wordpress/meme1.png var/www/wordpress/
COPY srcs/test var/www/test/
COPY srcs/wordpress/header.jpg /
COPY srcs/self-signed.conf etc/nginx/snippets/
COPY srcs/ssl-params.conf etc/nginx/snippets/
COPY srcs/set_index.bash /
# create ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out \
	/etc/ssl/certs/nginx-selfsigned.crt -subj "/CN=localhost/"
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
	service php7.3-fpm start && \
	service mysql start && \
	bash create_DB.bash && \
	bash create_wp.bash && \
	mv header.jpg /var/www/wordpress/wp-content/themes/twentyseventeen/assets/images && \
	bash