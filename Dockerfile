FROM debian:10-slim

ARG DEBIAN_FRONTEND=noninteractive
COPY . /root/install
SHELL ["/bin/bash", "-c"]
RUN apt-get update && \
    apt-get -y install busybox "linux-image-$(uname -r)" && \
    cd /root/install && \
    sh ./install.sh && \
    ln -s /bin/busybox /bin/ifconfig && \
    ln -s /bin/busybox /bin/ping && \
    ln -s /bin/busybox /bin/route && \
    ln -s /usr/sbin/cron /usr/sbin/crond && \
    rm -rf /bin/ps && ln -s /bin/busybox /bin/ps;


ENTRYPOINT ["sh", "/sbin/docker-entrypoint"]
### Networking configuration
EXPOSE 80 443 5060/udp 5060/tcp 5038 8088 8089 10000-11000/udp