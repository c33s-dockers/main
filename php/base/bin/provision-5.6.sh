#!/bin/bash
########################################################################################################################
# Banner
########################################################################################################################
echo "running provision for"
figlet PHP ${DOCKER_PHP_VERSION}


# does not use base-provision.sh!

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

DOCKER_PHP_VERSION_MAJOR=5


#https://packages.debian.org/jessie/php5-cli
#The following extensions are built in: bcmath bz2 calendar Core ctype date dba dom ereg exif fileinfo filter ftp gettext
# hash iconv libxml mbstring mhash openssl pcntl pcre Phar posix Reflection session shmop SimpleXML soap sockets SPL standard
# sysvmsg sysvsem sysvshm tokenizer wddx xml xmlreader xmlwriter zip zlib

#        php$DOCKER_PHP_VERSION_MAJOR-apcu-bc \
#        php$DOCKER_PHP_VERSION_MAJOR-bcmath \
#        php$DOCKER_PHP_VERSION_MAJOR-mbstring \
#        php$DOCKER_PHP_VERSION_MAJOR-mongodb \
#        php$DOCKER_PHP_VERSION_MAJOR-opcache \
#        php$DOCKER_PHP_VERSION_MAJOR-xml \
#        php$DOCKER_PHP_VERSION_MAJOR-bz2 \
#        php$DOCKER_PHP_VERSION_MAJOR-zip

apt-get update && apt-get install --quiet --yes --no-install-recommends \
        php$DOCKER_PHP_VERSION_MAJOR-cli \
        php$DOCKER_PHP_VERSION_MAJOR-apcu \
        php$DOCKER_PHP_VERSION_MAJOR-common \
        php$DOCKER_PHP_VERSION_MAJOR-curl \
        php$DOCKER_PHP_VERSION_MAJOR-enchant \
        php$DOCKER_PHP_VERSION_MAJOR-gd \
        php$DOCKER_PHP_VERSION_MAJOR-geoip \
        php$DOCKER_PHP_VERSION_MAJOR-gmp \
        php$DOCKER_PHP_VERSION_MAJOR-imagick \
        php$DOCKER_PHP_VERSION_MAJOR-imap \
        php$DOCKER_PHP_VERSION_MAJOR-intl \
        php$DOCKER_PHP_VERSION_MAJOR-json \
        php$DOCKER_PHP_VERSION_MAJOR-ldap \
        php$DOCKER_PHP_VERSION_MAJOR-readline \
        php$DOCKER_PHP_VERSION_MAJOR-mcrypt \
        php$DOCKER_PHP_VERSION_MAJOR-memcached \
        php$DOCKER_PHP_VERSION_MAJOR-mongo \
        php$DOCKER_PHP_VERSION_MAJOR-mysql \
        php-apc \
        php$DOCKER_PHP_VERSION_MAJOR-pgsql \
        php$DOCKER_PHP_VERSION_MAJOR-redis \
        php$DOCKER_PHP_VERSION_MAJOR-sqlite \
        php$DOCKER_PHP_VERSION_MAJOR-ssh2 \
        php$DOCKER_PHP_VERSION_MAJOR-xdebug \
        php$DOCKER_PHP_VERSION_MAJOR-xmlrpc \
        php$DOCKER_PHP_VERSION_MAJOR-xsl
apt-get clean -qq
apt-get autoremove -qq && ( -rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* >/dev/null 2>&1 || true ) \
    && ( echo 'date.timezone="Europe/Vienna"' >> /etc/php5/cli/conf.d/timezone.ini || true )
#    && rm -rf /etc/php/$DOCKER_PHP_VERSION_MAJOR/cli/conf.d/20-xdebug.ini

cat << EOF > /usr/local/bin/ci-ssh-key-mapper
#!/bin/bash

TARGET=${1^^}

NAME_KEY_PRIVATE=${TARGET}_KEY_PRIVATE
NAME_HOST_KEY=${TARGET}_HOST_KEY
NAME_SSH_CONFIG_EVAL=${TARGET}_SSH_CONFIG_EVAL
NAME_SSH_CONFIG=${TARGET}_SSH_CONFIG

KEY_PRIVATE=${!NAME_KEY_PRIVATE}
HOST_KEY=${!NAME_HOST_KEY}
SSH_CONFIG_EVAL=${!NAME_SSH_CONFIG_EVAL}
SSH_CONFIG=${!NAME_SSH_CONFIG}

eval $(ssh-agent -s)
ssh-add <(echo "$KEY_PRIVATE")
echo -e "$HOST_KEY\n\n" > ~/.ssh/known_hosts
cat ~/.ssh/known_hosts
IFSBACKUP=$IFS
IFS=";"
eval $SSH_CONFIG_EVAL
cat <<<$SSH_CONFIG >> ~/.ssh/config
IFS=$IFSBACKUP
cat ~/.ssh/config
EOF

########################################################################################################################
# Php Phar Utils (code duplicated in `provision-base_7.x.sh`)
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
