#!/bin/bash

if [ ! -d ./pki ]; then
   mkdir ./pki
fi

# Create Root CA
if [ ! -d ./pki/RootCA ]; then
   ./initRootCA.sh
fi


# Create additional Proxy CA for SSL-Interception 
docker run -it --rm --network=none -e EASYRSA_PKI_NAME=ProxyCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa init-pki
docker run -it --rm --network=none -e EASYRSA_PKI_NAME=ProxyCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa build-ca subca
#docker run -it --rm --network=none -e EASYRSA_PKI_NAME=ProxyCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa gen-dh
docker run -it --rm --network=none -e EASYRSA_PKI_NAME=proxyCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa gen-crl


# Import the ProxyCA request under the short name "ProxyCA" on the "RootCA"
docker run -it --rm --network=none -e EASYRSA_PKI_NAME=RootCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa import-req ProxyCA/reqs/ca.req ProxyCA


# Sign the ProxyCA on the RootCA
docker run -it --rm --network=none -e EASYRSA_PKI_NAME=RootCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa sign-req ca ProxyCA


# Transport IssuingCA Cert to IssuingCA
cp ./pki/RootCA/issued/ProxyCA.crt ./pki/ProxyCA/ca.crt


echo Proxy Certificate Authority \(CA\) created
