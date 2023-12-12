FROM php:8.0-apache

WORKDIR /var/www/html

RUN apt-get update -y

RUN apt-get install -y libpng-dev && docker-php-ext-install gd
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo pdo_mysql
RUN docker-php-ext-install opcache
RUN apt-get install -y libicu-dev \ 
  && docker-php-ext-configure intl \
  && docker-php-ext-install intl
RUN apt-get install -y libxml2-dev && docker-php-ext-install soap
RUN docker-php-ext-install exif
RUN apt-get install -y \
        libzip-dev \
        zip \
  && docker-php-ext-install zip

COPY /opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY /php.ini /usr/local/etc/php/conf.d/php-ini-overrides.ini

RUN chmod -R 777 /var/www/html
RUN mkdir /var/www/moodledata
RUN chown -R www-data /var/www/moodledata
RUN chmod -R 777 /var/www/moodledata

EXPOSE 80