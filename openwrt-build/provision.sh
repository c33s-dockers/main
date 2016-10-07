#!/bin/bash
########################################################################################################################
# Base Setup
########################################################################################################################
apt-get update && apt-get install --quiet --yes --force-yes --no-install-recommends \
    git-core \
    build-essential \
    libssl-dev \
    libncurses5-dev \
    unzip \
    gawk \
    subversion \
    mercurial \
    && apt-get clean -qq \
    && apt-get autoremove -qq \
    && ( -rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* >/dev/null 2>&1 || true )
