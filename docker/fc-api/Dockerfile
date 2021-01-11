FROM php:8.0.0-fpm-alpine

RUN apk --no-cache update \
    && apk --no-cache upgrade \
    && apk add --no-cache --virtual \
    .build-deps \
    $PHPIZE_DEPS \
    gcc \
    g++ \
    autoconf \
    tar \
    && apk add --no-cache \
    libxslt-dev \
    tidyhtml-dev \
    net-snmp-dev \
    aspell-dev \
    freetds-dev \
    openldap-dev \
    gettext-dev \
    imap-dev \
    openssh \
    sudo \
    make \
    shadow \
    libmcrypt-dev \
    gmp-dev \
    openssl \
    mariadb-client \
    curl \
    freetype \
    libpng \
    libjpeg-turbo \
    freetype-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    libzip-dev \
    bzip2-dev \
    postgresql-dev \
    supervisor \
    bash \
    nginx \
    pngquant \
    jpegoptim \
    zip \
    icu-dev \
    libxml2-dev \
    dcron \
    wget \
    rsync \
    ca-certificates \
    oniguruma-dev \
    && phpModules=" \
    bcmath \
    bz2 \
    calendar \
    exif \
    gd \
    gettext \
    gmp \
    imap \
    intl \
    ldap \
    mysqli \
    pcntl \
    pdo_dblib \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    pspell \
    shmop \
    snmp \
    soap \
    sockets \
    sysvmsg \
    sysvsem \
    sysvshm \
    tidy \
    xsl \
    " \
    && NPROC=$(getconf _NPROCESSORS_ONLN) \
    && docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp \
    #    Install APCU
    #    @see https://github.com/docker-library/php/issues/1029
    && mkdir -p /usr/src/php/ext/apcu  \
    && mkdir -p /usr/src/php/ext/amqp  \
    && mkdir -p /usr/src/php/ext/igbinary  \
    && mkdir -p /usr/src/php/ext/mongodb  \
    && mkdir -p /usr/src/php/ext/redis  \
    && curl -fsSL https://pecl.php.net/get/apcu | tar xvz -C "/usr/src/php/ext/apcu" --strip 1 \
    && curl -fsSL https://pecl.php.net/get/amqp | tar xvz -C "/usr/src/php/ext/amqp" --strip 1 \
    && curl -fsSL https://pecl.php.net/get/igbinary | tar xvz -C "/usr/src/php/ext/igbinary" --strip 1 \
    && curl -fsSL https://pecl.php.net/get/mongodb | tar xvz -C "/usr/src/php/ext/mongodb" --strip 1 \
    && curl -fsSL https://pecl.php.net/get/redis | tar xvz -C "/usr/src/php/ext/redis" --strip 1 \
    && docker-php-ext-install -j${NPROC} $phpModules \
    && apk del --no-cache gcc g++ freetype-dev libpng-dev libjpeg-turbo-dev .build-deps

RUN apk update && apk add --update --no-cache supervisor openssh git mysql-client

RUN docker-php-ext-install \
    mysqli \
    pdo \
    pdo_mysql

RUN apk --no-cache add pcre-dev ${PHPIZE_DEPS} \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del pcre-dev ${PHPIZE_DEPS} \
    && rm -rf /tmp/pear

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
