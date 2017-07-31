#!/bin/bash
########################################################################################################################
# Banner
########################################################################################################################
echo "running provision for"
figlet $(lsb_release -sc)
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