FROM php:8.1-fpm-alpine

RUN apk update && apk add autoconf g++ make \
    && apk add curl-dev zip unzip zlib-dev libpng-dev oniguruma-dev \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && rm -rf /tmp/pear
RUN pecl install redis \
    && docker-php-ext-enable redis
RUN docker-php-ext-install gd pdo pdo_mysql curl mbstring bcmath
RUN docker-php-ext-install pcntl
#    && docker-php-ext-configure pcntl --enable-pcntl \

RUN mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini

COPY ./common/php/conf.d /usr/local/etc/php/conf.d
COPY ./development/php/conf.d /usr/local/etc/php/conf.d
COPY ./development/php-fpm/conf.d /usr/local/etc/php/conf.d

WORKDIR /app

COPY ./development/php-fpm/entrypoint.sh /usr/local/bin/docker-php-entrypoint
RUN chmod +x /usr/local/bin/docker-php-entrypoint
