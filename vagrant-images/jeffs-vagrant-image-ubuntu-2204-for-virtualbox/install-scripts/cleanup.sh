#!/bin/bash -e
# my-packer-image-builds jeffs-vagrant-image-ubuntu-2204-for-virtualbox cleanup.sh

echo " "
echo "************************************************************************"
echo "*************************************************** cleanup.sh (START) *"
echo "You are root in /home/vagrant"
echo " "

#echo "Apt cleanup"

echo "apt autoremove"
apt autoremove
echo " "

echo "apt -y update"
apt -y update
echo " "

#echo "Zero out the rest of the free space using dd, then delete the written file"
#dd if=/dev/zero of=/EMPTY bs=1M
#rm -f /EMPTY

#echo "Add sync so Packer doesn't quit too early, before the large file is deleted"
#sync

echo "***************************************************** cleanup.sh (END) *"
echo "************************************************************************"
echo " "