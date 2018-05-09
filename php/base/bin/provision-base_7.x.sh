#!/bin/bash

if [ "$(lsb_release -sc)" = "stretch" ]; then
    ########################################################################################################################
    #  Sury Repo
    ########################################################################################################################
    cat << EOF > /etc/apt/sources.list.d/php.list
        deb https://packages.sury.org/php/ $(lsb_release -sc) main
EOF
    wget --no-clobber --quiet -O ./php.gpg https://packages.sury.org/php/apt.gpg
    apt-key add php.gpg
    apt-get update
    rm php.gpg
else
    ########################################################################################################################
    # DotDeb Repo
    ########################################################################################################################
    cat << EOF > /etc/apt/sources.list.d/dotdeb.list
        deb http://packages.dotdeb.org jessie all
        deb-src http://packages.dotdeb.org jessie all
EOF
    wget --no-clobber --quiet https://www.dotdeb.org/dotdeb.gpg \
        && apt-key add dotdeb.gpg \
        && apt-get update \
        && rm dotdeb.gpg
fi

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
        mysql-client \
        postgresql-client \
        jpegoptim \
        optipng \
        pngquant \
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
        php$DOCKER_PHP_VERSION-mcrypt \
        php$DOCKER_PHP_VERSION-memcached \
        php$DOCKER_PHP_VERSION-mongodb \
        php$DOCKER_PHP_VERSION-mysql \
        php$DOCKER_PHP_VERSION-opcache \
        php$DOCKER_PHP_VERSION-pgsql \
        php$DOCKER_PHP_VERSION-redis \
        php$DOCKER_PHP_VERSION-sqlite3 \
        php$DOCKER_PHP_VERSION-ssh2 \
        php$DOCKER_PHP_VERSION-xdebug \
        php$DOCKER_PHP_VERSION-xml \
        php$DOCKER_PHP_VERSION-xmlrpc \
        php$DOCKER_PHP_VERSION-xsl \
        php$DOCKER_PHP_VERSION-zip
apt-get clean -qq
apt-get autoremove -qq && ( -rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* >/dev/null 2>&1 || true ) \
    && echo 'date.timezone="Europe/Vienna"' >> /etc/php/${DOCKER_PHP_VERSION}/cli/conf.d/timezone.ini \
    && echo 'clear_env="no"'                >> /etc/php/${DOCKER_PHP_VERSION}/cli/conf.d/env.ini \
    && echo 'variables_order="EGPCS"'       >> /etc/php/${DOCKER_PHP_VERSION}/cli/conf.d/env.ini
#    && rm -rf /etc/php/$DOCKER_PHP_VERSION/cli/conf.d/20-xdebug.ini

cat << EOF > /usr/local/bin/ci-ssh-key-mapper
#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 1
fi

TARGET=${1^^}

NAME_HOST=${TARGET}_HOST
NAME_PATH=${TARGET}_PATH
NAME_PORT=${TARGET}_PORT
NAME_KEY_PRIVATE=${TARGET}_KEY_PRIVATE
NAME_KNOWN_HOSTS=${TARGET}_KNOWN_HOSTS

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

########################################################################################################################
# Php Phar Utils (code duplicated in `provision-5.6.sh`)
########################################################################################################################

wget --no-verbose https://getcomposer.org/download/${DOCKER_VERSION_COMPOSER}/composer.phar --output-document=/usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer \
    && composer self-update \
    && composer --ansi global require hirak/prestissimo:${DOCKER_VERSION_COMPOSER_PRESTISSIMO} \
    && composer --ansi global require fxp/composer-asset-plugin:${DOCKER_VERSION_COMPOSER_ASSET_PLUGIN} \
    && composer --version

wget --no-verbose https://symfony.com/installer --output-document=/usr/local/bin/symfony \
    && chmod a+x /usr/local/bin/symfony \
    && symfony --version

wget --no-verbose https://github.com/consolidation/Robo/releases/download/${DOCKER_VERSION_ROBO}/robo.phar --output-document=/usr/local/bin/robo \
    && chmod a+x /usr/local/bin/robo \
    && robo --version

wget --no-verbose https://github.com/box-project/box2/releases/download/${DOCKER_VERSION_BOX}/box-${DOCKER_VERSION_BOX}.phar --output-document=/usr/local/bin/box \
    && chmod a+x /usr/local/bin/box \
    && box --version
