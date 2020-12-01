#!/bin/bash
########################################################################################################################
# Banner
########################################################################################################################
echo "running provision for"
figlet $(lsb_release -sc)

/etc/apt/sources.list.d
apt-get install --fix-broken
apt-get upgrade --fix-missing
apt-get update --fix-broken
apt-get upgrade --fix-broken
apt-get install --fix-broken
apt-get install --fix-broken --yes git
apt-get install --fix-broken --quiet --yes --no-install-recommends \
    apt-transport-https \
    apt-utils \
    aptitude \
    ca-certificates


#ls -lsa /etc/apt/*
#cat /etc/apt/*
set -x
rm -rf /etc/apt/sources.list
rm -rf /etc/apt/sources.list.d/backports.list
echo 'Acquire::Check-Valid-Until no;' > /etc/apt/apt.conf.d/99no-check-valid-until
cat << EOF > /etc/apt/sources.list
deb http://archive.debian.org/debian/ wheezy-backports main
deb http://archive.debian.org/debian/ wheezy main contrib non-free
EOF

#deb http://archive.debian.org/debian/dists/wheezy-backports/ wheezy-backports main

#deb http://deb.debian.org/debian wheezy main
#https://www.debian.org/distrib/archive
#http://archive.debian.org/debian/.
#deb http://archive.debian.org/debian/ hamm contrib main non-free
#deb http://archive.debian.org/debian/ bo bo-unstable contrib main non-free
#http://archive.debian.org/debian-backports/
#http://archive.debian.org/debian/dists/wheezy-backports/

ls -lsa /etc/apt/*
cat /etc/apt/*
#tree

#https://www.debian.org/distrib/archive
#http://archive.debian.org/debian/.
#deb http://archive.debian.org/debian/ hamm contrib main non-free
#deb http://archive.debian.org/debian/ bo bo-unstable contrib main non-free
#http://archive.debian.org/debian-backports/
#http://archive.debian.org/debian/dists/wheezy-backports/

#ls -lsa /etc/apt/*
#cat /etc/apt/*
set -x
rm -rf /etc/apt/sources.list
rm -rf /etc/apt/sources.list.d/backports.list
echo 'Acquire::Check-Valid-Until no;' > /etc/apt/apt.conf.d/99no-check-valid-until
cat << EOF > /etc/apt/sources.list
deb http://archive.debian.org/debian/ wheezy-backports main
deb http://archive.debian.org/debian/ wheezy main contrib non-free
EOF

#deb http://archive.debian.org/debian/dists/wheezy-backports/ wheezy-backports main

#deb http://deb.debian.org/debian wheezy main
#https://www.debian.org/distrib/archive
#http://archive.debian.org/debian/.
#deb http://archive.debian.org/debian/ hamm contrib main non-free
#deb http://archive.debian.org/debian/ bo bo-unstable contrib main non-free
#http://archive.debian.org/debian-backports/
#http://archive.debian.org/debian/dists/wheezy-backports/
apt-get install --fix-broken
apt-get upgrade --fix-missing
apt-get update --fix-broken
apt-get upgrade --fix-broken
apt-get install --fix-broken
apt-get install --fix-broken --yes git

wget --sslcheckcert=0 --debug --no-check-certificate https://dl.min.io/client/mc/release/linux-amd64/archive/mc.RELEASE.${MINIO_VERSION} -O ${MINIO_PATH} \
&& chmod +x ${MINIO_PATH}
echo "${MINIO_SHA256} ${MINIO_PATH}" | sha256sum --check - || exit 1


mi --version
