ARG PHP_VERSION=8.3
ARG PHP_VARIANT=debug

FROM php:${PHP_VERSION}-alpine

# Adds install-php-extensions
ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

ENV PHP_DEV_EXTENSIONS="xdebug pcov" \
    PHP_MASTER_EXTENSIONS="\
            ev \
            gd \
            pdo \
            pdo_mysql \
            pdo_pgsql \
            zip \
            csv \
            soap \
            brotli \
            intl \
            geospatial \
            geos \
            bcmath \
            bitset \
            calendar \
            mbstring \
            mcrypt \
            mysqli \
            mongodb \
            pgsql \
            xsl \
            gmp \
            sockets \
            ftp \
            ssh2 \
            uuid \
            curl \
            redis \
            exif \
            bz2 \
            pcntl \
            opcache \
            yaml"

# Adds php extensions
RUN if [ "$PHP_VARIANT" = "debug" ]; then  \
      install-php-extensions $PHP_MASTER_EXTENSIONS $PHP_DEV_EXTENSIONS; \
    else  \
      install-php-extensions $PHP_MASTER_EXTENSIONS; \
    fi \
    && apk add nodejs-current npm \
    && npm install -g yarn
