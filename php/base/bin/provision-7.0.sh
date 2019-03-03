#!/bin/bash
########################################################################################################################
# Banner
########################################################################################################################
echo "running provision for"
figlet PHP ${DOCKER_PHP_VERSION}

apt-get update && apt-get install --quiet --yes --no-install-recommends \
        php$DOCKER_PHP_VERSION-mcrypt

echo 'phar.readonly="0"' >> /etc/php/7.0/cli/conf.d/ci.ini
