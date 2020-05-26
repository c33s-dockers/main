#!/bin/bash

version_compare_lte() {
    [  "$1" = "`echo -e "$1\n$2" | sort --version-sort | head -n1`" ]
}

version_compare_lt() {
    [ "$1" = "$2" ] && return 1 || version_compare_lte $1 $2
}

version_compare_gte() {
    [  "$1" = "`echo -e "$1\n$2" | sort --version-sort --reverse | head -n1`" ]
}

version_compare_gt() {
    [ "$1" = "$2" ] && return 1 || version_compare_gte $1 $2
}

case "$(lsb_release -sc)" in
########################################################################################################################
wheezy) #7 #############################################################################################################
    echo "wheezy is deprecated"
    ;;
########################################################################################################################
jessie) #8 #############################################################################################################
#    RELEASE_SPECIFIC_PACKAGES=mysql-client
    # DotDeb Repo ###
    cat << EOF > /etc/apt/sources.list.d/dotdeb.list
        deb http://packages.dotdeb.org jessie all
        deb-src http://packages.dotdeb.org jessie all
EOF
    wget --no-clobber --quiet https://www.dotdeb.org/dotdeb.gpg \
        && apt-key add dotdeb.gpg \
        && apt-get update \
        && rm dotdeb.gpg
    # END DotDeb Repo ###
    ;;
########################################################################################################################
stretch) #9 ############################################################################################################
#    RELEASE_SPECIFIC_PACKAGES=mysql-client
    # Sury Repo ###
    cat << EOF > /etc/apt/sources.list.d/php.list
        deb https://packages.sury.org/php/ $(lsb_release -sc) main
EOF
    wget --no-clobber --quiet -O ./php.gpg https://packages.sury.org/php/apt.gpg
    apt-key add php.gpg
    apt-get update
    rm php.gpg
    # END Sury Repo ###
    ;;
########################################################################################################################
buster) #10 ############################################################################################################
#    RELEASE_SPECIFIC_PACKAGES=mysql-client
    # Sury Repo ###
    cat << EOF > /etc/apt/sources.list.d/php.list
        deb https://packages.sury.org/php/ $(lsb_release -sc) main
EOF
    wget --no-clobber --quiet -O ./php.gpg https://packages.sury.org/php/apt.gpg
    apt-key add php.gpg
    apt-get update
    rm php.gpg
    # END Sury Repo ###
    ;;
########################################################################################################################
*) #* ##################################################################################################################
    echo "WARNING: no compatible release"
    ;;
esac

########################################################################################################################
# Yarn Repo
########################################################################################################################
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

########################################################################################################################
# Node Repo
########################################################################################################################
curl -sL https://deb.nodesource.com/setup_8.x | bash -

########################################################################################################################
wget https://mozjpeg.codelove.de/bin/mozjpeg_3.1_amd64.deb
dpkg -i mozjpeg_3.1_amd64.deb
apt-get update && apt-get install --quiet --yes --no-install-recommends \
        yarn \
        nodejs \
        mariadb-client \
        postgresql-client \
        jpegoptim \
        optipng \
        pngquant \
        dnsutils \
        php$DOCKER_PHP_VERSION-cli \
        php$DOCKER_PHP_VERSION-apcu \
        php$DOCKER_PHP_VERSION-apcu-bc \
        php$DOCKER_PHP_VERSION-bcmath \
        php$DOCKER_PHP_VERSION-bz2 \
        php$DOCKER_PHP_VERSION-common \
        php$DOCKER_PHP_VERSION-curl \
        php$DOCKER_PHP_VERSION-enchant \
        php$DOCKER_PHP_VERSION-gd \
        php$DOCKER_PHP_VERSION-geoip \
        php$DOCKER_PHP_VERSION-gmp \
        php$DOCKER_PHP_VERSION-imagick \
        php$DOCKER_PHP_VERSION-imap \
        php$DOCKER_PHP_VERSION-intl \
        php$DOCKER_PHP_VERSION-json \
        php$DOCKER_PHP_VERSION-ldap \
        php$DOCKER_PHP_VERSION-readline \
        php$DOCKER_PHP_VERSION-mbstring \
        php$DOCKER_PHP_VERSION-memcached \
        php$DOCKER_PHP_VERSION-mongodb \
        php$DOCKER_PHP_VERSION-mysql \
        php$DOCKER_PHP_VERSION-opcache \
        php$DOCKER_PHP_VERSION-pgsql \
        php$DOCKER_PHP_VERSION-redis \
        php$DOCKER_PHP_VERSION-sqlite3 \
        php$DOCKER_PHP_VERSION-ssh2 \
        php$DOCKER_PHP_VERSION-soap \
        php$DOCKER_PHP_VERSION-mailparse \
        php$DOCKER_PHP_VERSION-xdebug \
        php$DOCKER_PHP_VERSION-xml \
        php$DOCKER_PHP_VERSION-xmlrpc \
        php$DOCKER_PHP_VERSION-xsl \
        php$DOCKER_PHP_VERSION-zip

#        php$DOCKER_PHP_VERSION-mcrypt \ # is installed for php7.0 and php7.1, in php7.2 it is deprecated.

if version_compare_gte "$DOCKER_PHP_VERSION" "7.1"; then
apt-get update && apt-get install --quiet --yes --no-install-recommends \
        php$DOCKER_PHP_VERSION-pcov \
else
    echo "skipped to install pcov, php version to low. sury only provides pcov requires a minimum php version of 7.1"
fi

apt-get clean -qq
apt-get autoremove -qq && ( -rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* >/dev/null 2>&1 || true ) \
    && echo 'date.timezone="Europe/Vienna"' >> /etc/php/${DOCKER_PHP_VERSION}/cli/conf.d/timezone.ini \
    && echo 'clear_env="no"'                >> /etc/php/${DOCKER_PHP_VERSION}/cli/conf.d/env.ini \
    && echo 'variables_order="EGPCS"'       >> /etc/php/${DOCKER_PHP_VERSION}/cli/conf.d/env.ini
#    && rm -rf /etc/php/$DOCKER_PHP_VERSION/cli/conf.d/20-xdebug.ini

cat << 'EOF' > /usr/local/bin/ci-ssh-key-mapper
#!/bin/bash

PREFIX=""
if [ $# -ge 1 ]
  then
    # ^^=uppercase
    PREFIX="${1^^}_"
fi

NAME_HOST=${PREFIX}HOST
NAME_PATH=${PREFIX}PATH
NAME_PORT=${PREFIX}PORT
NAME_KEY_PRIVATE=${PREFIX}KEY_PRIVATE
NAME_KNOWN_HOSTS=${PREFIX}KNOWN_HOSTS

# ${!....}=indirect expansion -> variable variable -> content of DEPLOY_HOST = content of the variable which name is
# stored in the variable NAME_HOST. so if NAME_HOST contains PRODUCTION_HOST where PRODUCTION_HOST is example.com the
# content of DEPLOY_HOST=example.com
# https://stackoverflow.com/a/8515492
export DEPLOY_HOST=${!NAME_HOST}
export DEPLOY_PATH=${!NAME_PATH}
export DEPLOY_PORT=${!NAME_PORT}
export DEPLOY_KEY_PRIVATE=${!NAME_KEY_PRIVATE}
export DEPLOY_KNOWN_HOSTS=${!NAME_KNOWN_HOSTS}


eval $(ssh-agent -s)
echo "$DEPLOY_KEY_PRIVATE" | tr -d '\r' | ssh-add - > /dev/null
ssh-add -L
echo "$DEPLOY_KNOWN_HOSTS" > ~/.ssh/known_hosts
chmod 644 ~/.ssh/known_hosts

EOF
chmod ugo+x /usr/local/bin/ci-ssh-key-mapper

cat << EOF > /etc/profile.d/mozjpeg.sh
if ! echo $PATH | grep -q /opt/mozjpeg/bin ; then
  export PATH=$PATH:/opt/mozjpeg/bin
fi

EOF
chmod ugo+x /etc/profile.d/mozjpeg.sh

echo 'phar.readonly="0"' >> /etc/php/${DOCKER_PHP_VERSION}/cli/conf.d/ci.ini

########################################################################################################################
# Php Phar Utils (partial code duplicated in `provision-5.6.sh`)
########################################################################################################################

wget --no-verbose https://getcomposer.org/download/${DOCKER_VERSION_COMPOSER}/composer.phar --output-document=/usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer \
    && composer self-update \
    && composer --ansi global require hirak/prestissimo:${DOCKER_VERSION_COMPOSER_PRESTISSIMO} \
    && composer --ansi global require fxp/composer-asset-plugin:${DOCKER_VERSION_COMPOSER_ASSET_PLUGIN} \
    && composer --version

wget --no-verbose https://github.com/consolidation/Robo/releases/download/${DOCKER_VERSION_ROBO}/robo.phar --output-document=/usr/local/bin/robo \
    && chmod a+x /usr/local/bin/robo \
    && robo --version

wget --no-verbose https://github.com/box-project/box2/releases/download/${DOCKER_VERSION_BOX}/box-${DOCKER_VERSION_BOX}.phar --output-document=/usr/local/bin/box \
    && chmod a+x /usr/local/bin/box \
    && box --version

if version_compare_gte "$DOCKER_PHP_VERSION" "7.1"; then
    echo "installing box3.phar"
    wget --no-verbose https://github.com/humbug/box/releases/download/${DOCKER_VERSION_BOX3}/box.phar --output-document=/usr/local/bin/box3 \
        && chmod a+x /usr/local/bin/box3 \
        && box3 --version
else
    echo "skipped to install box3.phar, php version to low. box3 requires a minimum php version of 7.1"
fi
