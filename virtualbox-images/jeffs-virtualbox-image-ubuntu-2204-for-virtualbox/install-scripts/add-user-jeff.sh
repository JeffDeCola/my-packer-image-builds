#!/bin/sh -e
# my-packer-image-builds jeffs-virtualbox-image-ubuntu-2204-for-virtualbox add-user-jeff.sh

echo " " 
echo "************************************************************************"
echo "********************************************* add-user-jeff.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "adduser"
sudo adduser --disabled-password --gecos "" jeff
sudo passwd -d jeff
echo " "

echo "*********************************************** add-user-jeff.sh (END) *"
echo "************************************************************************"
echo " "