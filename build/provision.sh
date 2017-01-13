#!/bin/bash
####################################################################################################
# Initial Commit
####################################################################################################
apt-get update -yqq && apt-get upgrade -yqq

####################################################################################################
# NodeJs Repo
####################################################################################################
curl -sL https://deb.nodesource.com/setup_4.x | bash - \
    && apt-get update && apt-get install --quiet --yes --force-yes --no-install-recommends \
        nodejs \
        npm \
    && apt-get clean -qq \
    && apt-get autoremove -qq \
    && ( -rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* >/dev/null 2>&1 || true )

####################################################################################################
# Node Stuff
####################################################################################################
echo 'export PATH="$PATH:/usr/local/.npm/bin"' >> /etc/profile
export PATH="$PATH:/usr/local/.npm/bin"
npm config --global set prefix '/usr/local/.npm'

####################################################################################################
# CI Stuff
####################################################################################################
apt-get update && apt-get install --quiet --yes --force-yes --no-install-recommends \
        nodejs \
        ruby \
        ruby-dev \
        rubygems \
        build-essential \
        devscripts \
        debhelper \
        dh-make \
        rpm \
    && gem install --no-ri --no-rdoc fpm \
    && apt-get clean -qq \
    && apt-get autoremove -qq \
    && ( -rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* >/dev/null 2>&1 || true )
