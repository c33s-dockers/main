#!/bin/bash
########################################################################################################################
# Base Setup
########################################################################################################################
apt-get update
apt-get install --quiet --yes --no-install-recommends \
    sudo \
    build-essential \
    debhelper \
    devscripts \
    dh-make \
    rubygems-integration \
    libtool \
    libtool-bin \
    pkgconf \
    yajl-tools \
    rdmacm-utils \
    automake \
    bison \
    dh-autoreconf \
    flex \
    gzip \
    tar \
    ruby-ronn \
    rpm \
    ruby \
    ruby-dev \
    checkinstall \
    fakeroot \
    equivs \
    g++ \
    curl
gem install --no-document fpm
apt-get clean -qq
apt-get autoremove -qq && ( -rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* >/dev/null 2>&1 || true )
