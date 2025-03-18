FROM ubuntu:24.04

ENV BIND_USER=bind \
    BIND_VERSION=9.18.30 \
    WEBMIN_VERSION=2.303 \
    DATA_DIR=/data

# install common package
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      bind9=1:${BIND_VERSION}* bind9-host=1:${BIND_VERSION}* \
      dnsutils \
      cron

# install webmin package
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl \
 && curl -o setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh \
 && sh setup-repos.sh -f \
 && DEBIAN_FRONTEND=noninteractive apt-get install --install-recommends -y webmin=${WEBMIN_VERSION}*

COPY rootfs/ /

RUN rm -rf /var/lib/apt/lists/* \
 && chmod 755 /entrypoint.sh /usr/bin/systemctl

EXPOSE 53/udp 53/tcp 10000/tcp

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/named"]
