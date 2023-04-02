#!/bin/sh -e
# my-packer-image-builds jeffs-gce-image-ubuntu-2204 remove-github-keys.sh

echo " " 
echo "************************************************************************"
echo "**************************************** remove-github-keys.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "cd /root/.ssh"
cd /root/.ssh

echo "Remove my private keys"
rm id_rsa
rm id_rsa.pub
echo " "

echo "****************************************** remove-github-keys.sh (END) *"
echo "************************************************************************"
echo " "