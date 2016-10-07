#!/bin/bash
########################################################################################################################
# Links
########################################################################################################################
# - https://unix.stackexchange.com/questions/252671/installing-php7-0-from-sid-on-jessie/252674#252674
   
########################################################################################################################
# Php
########################################################################################################################
apt-get update && apt-get install --quiet --yes --force-yes --no-install-recommends \
        php7.0-cli \
        php7.0-apcu \
        php7.0-apcu-bc \
        php7.0-bcmath \
        php7.0-bz2 \
        php7.0-common \
        php7.0-curl \
        php7.0-enchant \
        php7.0-gd \
        php7.0-geoip \
        php7.0-gmp \
        php7.0-imagick \
        php7.0-imap \
        php7.0-intl \
        php7.0-json \
        php7.0-ldap \
        php7.0-readline \
        php7.0-mbstring \
        php7.0-mcrypt \
        php7.0-memcached \
        php7.0-mongodb \
        php7.0-mysql \
        php7.0-opcache \
        php7.0-pgsql \
        php7.0-redis \
        php7.0-sqlite3 \
        php7.0-ssh2 \
        php7.0-xdebug \
        php7.0-xml \
        php7.0-xmlrpc \
        php7.0-xsl \
        php7.0-zip \
    && apt-get clean -qq \
    && apt-get autoremove -qq \
    && ( -rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* >/dev/null 2>&1 || true ) \
    && ( echo 'date.timezone="Europe/Vienna"' >> /etc/php/7.0/cli/conf.d/timezone.ini || true ) \
    && rm -rf /etc/php/7.0/cli/conf.d/20-xdebug.ini
    

