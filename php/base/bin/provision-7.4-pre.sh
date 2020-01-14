#!/bin/bash
########################################################################################################################
# Banner
########################################################################################################################
echo "running pre-provision for"
figlet PHP ${DOCKER_PHP_VERSION}

echo "adding sury repo"
# Sury Repo ###
cat << EOF > /etc/apt/sources.list.d/php.list
        deb https://packages.sury.org/php/ $(lsb_release -sc) main
EOF
wget --no-clobber --quiet -O ./php.gpg https://packages.sury.org/php/apt.gpg
apt-key add php.gpg
apt-get update
rm php.gpg
# END Sury Repo ###
