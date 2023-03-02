#!/bin/bash -e
# my-packer-image-builds jeffs-vagrant-image-ubuntu-2204-for-virtualbox-on-linux install-packages.sh

echo " "
echo "************************************************************************"
echo "****************************************** install-packages.sh (START) *"
echo "You are root in /home/vagrant"

echo "sudo apt-get -y install htop"
sudo apt-get -y install htop
echo " "

echo "******************************************** install-packages.sh (END) *"
echo "************************************************************************"
echo " "
