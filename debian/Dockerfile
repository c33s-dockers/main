FROM debian:jessie

MAINTAINER c33s

ARG DEBIAN_FRONTEND=noninteractive
COPY provision.sh /root/provision.sh
RUN chmod +x /root/provision.sh && /root/provision.sh
