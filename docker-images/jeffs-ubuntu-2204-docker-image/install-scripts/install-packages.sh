#!/bin/sh -e
# my-packer-image-builds install-packages.sh

echo " "
echo "************************************************************************"
echo "****************************************** install-packages.sh (START) *"
echo "You are root in /home/packer"
echo " "

apt-get -y install htop

echo "******************************************** install-packages.sh (END) *"
echo "************************************************************************"
echo " "
