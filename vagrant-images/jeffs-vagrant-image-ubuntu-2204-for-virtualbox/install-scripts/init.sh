#!/bin/bash -e
# my-packer-image-builds jeffs-vagrant-image-ubuntu-2204-for-virtualbox-on-linux jeffs-ubuntu-1804-virtualbox-vm-box init.sh

echo " "
echo "************************************************************************"
echo "****************************************************** init.sh (START) *"
echo "You are root in /home/vagrant"
echo " "

echo "whoami"
whoami
echo " "

echo "pwd"
pwd
echo " "

echo "Add vagrant user to sudoers"
echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
echo " "

echo "Disable daily apt unattended updates"
echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic
echo " "

echo "apt update"
apt update
echo " "

echo "apt upgrade -y"
apt upgrade -y
echo " "

echo "******************************************************** init.sh (END) *"
echo "************************************************************************"
echo " "