FROM debian:buster-backports

MAINTAINER c33s

ENV DOCKER_DEBIAN_CODENAME buster
ARG DEBIAN_FRONTEND=noninteractive

COPY bin/provision-base.sh /root/provision-base.sh
RUN chmod +x /root/provision-base.sh; sync; /root/provision-base.sh

COPY bin/provision-$DOCKER_DEBIAN_CODENAME.sh /root/provision-$DOCKER_DEBIAN_CODENAME.sh
RUN chmod +x /root/provision-$DOCKER_DEBIAN_CODENAME.sh; sync; /root/provision-$DOCKER_DEBIAN_CODENAME.sh
