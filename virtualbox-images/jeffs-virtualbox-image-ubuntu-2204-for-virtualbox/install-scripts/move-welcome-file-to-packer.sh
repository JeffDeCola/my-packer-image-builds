#!/bin/bash -e
# my-packer-image-builds jeffs-virtualbox-image-ubuntu-2204-for-virtualbox move-welcome-file.sh

echo " "
echo "************************************************************************"
echo "***************************************** move-welcome-file.sh (START) *"
echo "You are root in /home/vagrant"
echo " "

echo "mv /tmp/welcome.txt /home/vagrant"
mv /tmp/welcome.txt /home/vagrant
echo " "

echo "******************************************* move-welcome-file.sh (END) *"
echo "************************************************************************"
echo " "