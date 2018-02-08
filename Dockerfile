FROM debian:latest

USER root

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	apache2 \
	libapache2-mod-php7.0 \
	php-xml \
	php-mbstring \
	php-curl \
	php-zip \
	php-bcmath \
	php-mysql \
	mysql-client

COPY froxlor /var/www/html/froxlor

RUN chown www-data:www-data /var/www/html/froxlor -R
RUN sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\/froxlor/' /etc/apache2/sites-available/000-default.conf

CMD /usr/sbin/apache2ctl -D FOREGROUND
