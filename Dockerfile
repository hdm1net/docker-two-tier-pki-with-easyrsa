FROM alpine

LABEL maintainer="hd@hd-m1-net.de"

# Default PKI-Name
ENV EASYRSA_PKI_NAME="pki"

#set proxies for alpine apk package manager
ARG all_proxy 

ENV http_proxy=$all_proxy \
    https_proxy=$all_proxy

RUN apk update && \
    apk add --no-cache \
    easy-rsa \
    bash && \
    (rm -rf /var/cache/apk/* 2>/dev/null || true) && \
    mkdir /easy-rsa && \
    mkdir /easy-rsa.conf && \
    cp -f /usr/share/easy-rsa/easyrsa /usr/bin/easyrsa

COPY vars /easy-rsa.conf
COPY openssl-easyrsa.cnf /easy-rsa.conf
COPY docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh

WORKDIR /easy-rsa

ENTRYPOINT ["/docker-entrypoint.sh"]
