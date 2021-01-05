FROM php:8.0.0-fpm-alpine

RUN apk update && apk add supervisor openssh git

WORKDIR /

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN git clone https://github.com/juanitotrrj/fc-api.git app

RUN php -r "copy('https://getcomposer.org/installer', '/usr/local/bin/composer-setup.php');" && \
    php /usr/local/bin/composer-setup.php && \
    php -r "unlink('/usr/local/bin/composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer

WORKDIR /app

RUN composer install --dev && php artisan l5-swagger:generate

RUN chown -R www-data:www-data /app
