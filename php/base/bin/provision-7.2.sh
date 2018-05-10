#!/bin/bash
########################################################################################################################
# Banner
########################################################################################################################
echo "running provision for"
figlet PHP ${DOCKER_PHP_VERSION}

echo "nothing to do right now"

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


