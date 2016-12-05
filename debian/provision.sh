#!/bin/bash
########################################################################################################################
# Base Setup
########################################################################################################################
apt-get update && apt-get install --quiet --yes --force-yes --no-install-recommends \
    apt-utils \
    ca-certificates \
    curl \
    git \
    grep \
    lynx \
    openssh-client \
    rsync \
    software-properties-common \
    unzip \
    wget \
    zip \
    lftp \
    openssh-client \
    && apt-get clean -qq \
    && apt-get autoremove -qq \
    && ( -rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* >/dev/null 2>&1 || true )
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

########################################################################################################################
# ssh
########################################################################################################################
mkdir -p ~/.ssh \
    && ssh-keyscan -H github.com >> ~/.ssh/known_hosts \
    && ssh-keyscan -H gitlab.com >> ~/.ssh/known_hosts \
    && ssh-keyscan -H bitbucket.org >> ~/.ssh/known_hosts \
    && cat << EOF > ~/.ssh/config
Host github.com
    HostName github.com
    User git
    Port 22
Host gitlab.com
    HostName gitlab.com
    User git
    Port 22
Host bitbucket.org
    HostName bitbucket.org
    User git
    Port 22
EOF
