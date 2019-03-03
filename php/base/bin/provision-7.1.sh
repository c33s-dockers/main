#!/bin/bash
########################################################################################################################
# Banner
########################################################################################################################
echo "running provision for"
figlet PHP ${DOCKER_PHP_VERSION}

apt-get update && apt-get install --quiet --yes --no-install-recommends \
        php$DOCKER_PHP_VERSION-mcrypt

echo 'phar.readonly="0"' >> /etc/php/7.1/cli/conf.d/ci.ini

wget --no-verbose https://github.com/humbug/box/releases/download/${DOCKER_VERSION_BOX3}/box.phar --output-document=/usr/local/bin/box3 \
    && chmod a+x /usr/local/bin/box3 \
    && box3 --version
