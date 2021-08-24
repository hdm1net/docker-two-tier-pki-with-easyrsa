# Docker container: Two-Tier EASY-RSA Certification Authority
Projekt to run a Two-Tier-CA with RootCA and IssuingCA with EASY-RSA in a Docker container.

Requirements
--
You need a Docker installation to run. Only Linux is tested at this time.

Usage
--
1. Edit and customize the vars file
2. Build the Docker-Image with ./build.sh
3. Create the PKI's with ./init2TierCA.sh

See the sh-script for further usage.

