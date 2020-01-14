#!/bin/bash
########################################################################################################################
# Banner
########################################################################################################################
echo "running provision for"
figlet PHP ${DOCKER_PHP_VERSION}

echo 'phar.readonly="0"' >> /etc/php/7.2/cli/conf.d/ci.ini

# mcrypt deprecated for php7.2
# use pecl to install
# https://stackoverflow.com/questions/48275494/issue-in-installing-php7-2-mcrypt
# https://lukasmestan.com/install-mcrypt-extension-in-php7-2/
# https://pecl.php.net/package/mcrypt
# https://serverpilot.io/community/articles/how-to-install-the-php-mcrypt-extension.html
# apt-get install php-pear
# apt-get install libmcrypt-dev libreadline-dev
# pecl install mcrypt-1.0.1
#
# or use mcrypt_compat
#
# https://github.com/phpseclib/mcrypt_compat
# https://packagist.org/packages/phpseclib/mcrypt_compat
#
# or
#
# Varien_Crypt_Openssl
# https://github.com/OpenMage/magento-lts/issues/449


wget --no-verbose https://github.com/humbug/box/releases/download/${DOCKER_VERSION_BOX3}/box.phar --output-document=/usr/local/bin/box3 \
    && chmod a+x /usr/local/bin/box3 \
    && box3 --version
