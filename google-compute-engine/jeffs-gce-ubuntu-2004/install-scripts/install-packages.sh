#!/bin/bash -e
# my-packer-image-builds install-packages.sh

echo " "
echo "************************************************************************"
echo "****************************************** install-packages.sh (START) *"
echo "You are root in /home/packer"
echo " "

# sudo apt-get install -y git
sudo apt-get -y install tmux
sudo apt-get -y install htop
sudo apt-get -y install unzip
sudo apt-get -y install build-essential

echo "******************************************** install-packages.sh (END) *"
echo "************************************************************************"
echo " "
