#!/bin/bash

set -e

if [ ! -f "/easy-rsa/openssl-easyrsa.cnf" ]; then
    echo "No openssl-easyrsa.cnf found. Copying ..." 
    cp /easy-rsa.conf/openssl-easyrsa.cnf /easy-rsa/
fi

if [ -d "/easy-rsa/$EASYRSA_PKI_NAME" ]; then
     if [ ! -f "/easy-rsa/$EASYRSA_PKI_NAME/safessl-easyrsa.cnf" ]; then
          echo "No safessl-easyrsa.cnf found. Copying ..."
          cp /easy-rsa.conf/openssl-easyrsa.cnf /easy-rsa/$EASYRSA_PKI_NAME/safessl-easyrsa.cnf
     fi
fi

if [ ! -f "/easy-rsa/vars" ]; then
    echo "No vars found. Copying ..."
    cp /easy-rsa.conf/vars /easy-rsa/
    chmod +x /easy-rsa/vars
fi

if [ ! -d "/easy-rsa/x509-types" ]; then
    echo "No x509-types found. Copying ..."
    cp -R /usr/share/easy-rsa/x509-types /easy-rsa/x509-types
fi

export EASYRSA_PKI=$PWD/$EASYRSA_PKI_NAME

exec /usr/bin/easyrsa --vars=/easy-rsa/vars $@

