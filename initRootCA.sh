#!/bin/bash

if [ ! -d ./pki ]; then
   mkdir ./pki
fi

docker run -it --rm --network=none -e EASYRSA_PKI_NAME=RootCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa init-pki
docker run -it --rm --network=none -e EASYRSA_PKI_NAME=RootCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa build-ca
docker run -it --rm --network=none -e EASYRSA_PKI_NAME=RootCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa gen-dh
docker run -it --rm --network=none -e EASYRSA_PKI_NAME=RootCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa gen-crl

