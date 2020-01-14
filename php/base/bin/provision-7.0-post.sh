#!/bin/bash
########################################################################################################################
# Banner
########################################################################################################################
echo "running provision for"
figlet PHP ${DOCKER_PHP_VERSION}

echo "installing mcrypt"
apt-get update && apt-get install --quiet --yes --no-install-recommends \
        php$DOCKER_PHP_VERSION-mcrypt
