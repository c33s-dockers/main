#!/bin/bash
########################################################################################################################
#  Ondřej Surý Repo
########################################################################################################################
cat << EOF > /etc/apt/sources.list.d/php.list
    deb https://packages.sury.org/php/ $(lsb_release -sc) main
EOF
wget --no-clobber --quiet -O ./php.gpg https://packages.sury.org/php/apt.gpg \
    && apt-key add php.gpg \
    && apt-get update \
    && rm php.gpg


