#!/bin/bash

if [ ! -d ./pki ]; then
   mkdir ./pki
fi

# Create Root CA
docker run -it --rm --network=none -e EASYRSA_PKI_NAME=RootCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa init-pki
docker run -it --rm --network=none -e EASYRSA_PKI_NAME=RootCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa build-ca
docker run -it --rm --network=none -e EASYRSA_PKI_NAME=RootCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa gen-dh
docker run -it --rm --network=none -e EASYRSA_PKI_NAME=RootCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa gen-crl


# Create Issuing CA
docker run -it --rm --network=none -e EASYRSA_PKI_NAME=IssuingCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa init-pki
docker run -it --rm --network=none -e EASYRSA_PKI_NAME=IssuingCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa build-ca issuingca
docker run -it --rm --network=none -e EASYRSA_PKI_NAME=IssuingCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa gen-dh
docker run -it --rm --network=none -e EASYRSA_PKI_NAME=IssuingCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa gen-crl


# Import the IssuingCA request under the short name "IssuingCA" on the "RootCA"
docker run -it --rm --network=none -e EASYRSA_PKI_NAME=RootCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa import-req IssuingCA/reqs/ca.req IssuingCA


# Sign the IssuingCA on the RootCA
docker run -it --rm --network=none -e EASYRSA_PKI_NAME=RootCA -v $(pwd)/pki:/easy-rsa hdm1net/easy-rsa sign-req ca IssuingCA


# Transport IssuingCA Cert to IssuingCA
cp ./pki/RootCA/issued/IssuingCA.crt ./pki/IssuingCA/ca.crt


echo.
echo 2-Tier-Certificate Authority (CA) created
