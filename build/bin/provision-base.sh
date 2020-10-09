#!/bin/bash
########################################################################################################################
# Base Setup
########################################################################################################################
apt-get update
apt-get install --quiet --yes --no-install-recommends \
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
    equivs
apt-get clean -qq
apt-get autoremove -qq && ( -rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* >/dev/null 2>&1 || true )
