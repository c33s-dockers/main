#!/bin/bash
########################################################################################################################
# Base Setup
########################################################################################################################
apt-get update
apt-get install --quiet --yes --no-install-recommends \
    apt-transport-https \
    apt-utils \
    aptitude \
    ca-certificates
apt-get install --quiet --yes --no-install-recommends \
    curl \
    figlet \
    git \
    gnupg \
    grep \
    lftp \
    lsb-release \
    lynx \
    openssh-client \
    rsync \
    software-properties-common \
    unzip \
    wget \
    tree \
    bzip2 \
    zip
apt-get clean -qq
apt-get autoremove -qq && ( -rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* >/dev/null 2>&1 || true )

########################################################################################################################
# ssh
########################################################################################################################
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
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
#rm /etc/ssh/ssh_host_rsa_key
#rm /etc/ssh/ssh_host_dsa_key

########################################################################################################################
# minio
########################################################################################################################
figlet $(lsb_release -sc)

MINIO_PATH=/usr/local/bin/mi

wget --quiet https://dl.min.io/client/mc/release/linux-amd64/archive/mc.RELEASE.${MINIO_VERSION} -O ${MINIO_PATH} \
&& chmod +x ${MINIO_PATH}
echo "${MINIO_SHA256} ${MINIO_PATH}" | sha256sum --check - || exit 1


mi --version
