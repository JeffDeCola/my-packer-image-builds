#!/bin/sh -e
# my-packer-image-builds jeffs-gce-image-ubuntu-2204 install-packages.sh

echo " "
echo "************************************************************************"
echo "****************************************** install-packages.sh (START) *"
echo "You are root in /home/packer"
echo " "

# sudo apt-get install -y git
echo "apt-get -y install tmux"
sudo apt-get -y install tmux
echo "apt-get -y install htop"
sudo apt-get -y install htop
echo "apt-get -y install unzip"
sudo apt-get -y install unzip
echo "apt-get -y install curl"
sudo apt-get -y install curl
echo "apt-get -y install build-essential"
sudo apt-get -y install build-essential
echo " "

echo "******************************************** install-packages.sh (END) *"
echo "************************************************************************"
echo " "
