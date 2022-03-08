FROM php:8.1-cli-alpine

RUN apk update && apk add autoconf g++ make \
    && pecl install xdebug \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable xdebug

RUN apk add curl-dev zip unzip zlib-dev libpng-dev oniguruma-dev \
    && docker-php-ext-install gd pdo pdo_mysql curl mbstring \
    && pecl install redis \
    && docker-php-ext-enable redis

RUN mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini

COPY ./common/php/conf.d /usr/local/etc/php/conf.d
COPY ./development/php/conf.d /usr/local/etc/php/conf.d

ENV COMPOSER_ALLOW_SUPERUSER 1

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer

WORKDIR /app
