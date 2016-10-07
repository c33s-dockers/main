FROM c33s/debian:latest

MAINTAINER c33s

ARG DEBIAN_FRONTEND=noninteractive
COPY provision.sh /root/provision.sh
RUN chmod +x /root/provision.sh

CMD ["php", "-a"]
