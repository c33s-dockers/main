#!/bin/bash
apt-get update && apt-get install --quiet --yes --no-install-recommends \
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
    && apt-get clean -qq \
    && apt-get autoremove -qq \
    && ( -rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* >/dev/null 2>&1 || true )

########################################################################################################################
# ssh
########################################################################################################################
#ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
#ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
#mkdir -p ~/.ssh \
#    && ssh-keyscan -H github.com >> ~/.ssh/known_hosts \
#    && ssh-keyscan -H gitlab.com >> ~/.ssh/known_hosts \
#    && ssh-keyscan -H bitbucket.org >> ~/.ssh/known_hosts \
#    && cat << EOF > ~/.ssh/config
#Host github.com
#    HostName github.com
#    User git
#    Port 22
#Host gitlab.com
#    HostName gitlab.com
#    User git
#    Port 22
#Host bitbucket.org
#    HostName bitbucket.org
#    User git
#    Port 22
#EOF
#rm /etc/ssh/ssh_host_rsa_key
#rm /etc/ssh/ssh_host_dsa_key