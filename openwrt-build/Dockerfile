FROM c33s/debian:jessie-1.0.0

MAINTAINER c33s

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install --quiet --yes --force-yes --no-install-recommends \
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