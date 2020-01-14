#!/bin/bash
########################################################################################################################
# Banner
########################################################################################################################

echo "running provision for"
figlet PHP ${DOCKER_PHP_VERSION}

# Sury Repo ###
cat << EOF > /etc/apt/sources.list.d/php.list
        deb https://packages.sury.org/php/ $(lsb_release -sc) main
EOF
wget --no-clobber --quiet -O ./php.gpg https://packages.sury.org/php/apt.gpg
apt-key add php.gpg
apt-get update
rm php.gpg
# END Sury Repo ###

echo 'phar.readonly="0"' >> /etc/php/7.4/cli/conf.d/ci.ini

wget --no-verbose https://github.com/humbug/box/releases/download/${DOCKER_VERSION_BOX3}/box.phar --output-document=/usr/local/bin/box3 \
    && chmod a+x /usr/local/bin/box3 \
    && box3 --version
