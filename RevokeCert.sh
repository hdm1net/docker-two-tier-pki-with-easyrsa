#!/bin/bash

docker run -it --rm --network=none -e EASYRSA_PKI_NAME=IssuingCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa revoke $@  
docker run -it --rm --network=none -e EASYRSA_PKI_NAME=IssuingCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa gen-crl 

