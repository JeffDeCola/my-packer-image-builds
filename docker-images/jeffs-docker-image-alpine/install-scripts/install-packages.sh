#!/bin/sh -e
# my-packer-image-builds jeffs-docker-image-alpine install-packages.sh

echo " "
echo "************************************************************************"
echo "****************************************** install-packages.sh (START) *"
echo "You are root in /home/packer"
echo " "

apk add bash
apk add htop

echo "******************************************** install-packages.sh (END) *"
echo "************************************************************************"
echo " "
