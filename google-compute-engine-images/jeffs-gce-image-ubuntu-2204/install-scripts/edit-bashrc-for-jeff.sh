#!/bin/sh -e
# my-packer-image-builds jeffs-gce-image-ubuntu-2204 edit-bashrc-for-jeff.sh

echo " " 
echo "************************************************************************"
echo "************************************** edit-bashrc-for-jeff.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "Add CDPATH to /home/jeff/.bashrc"
# Must escape $ with \$
cat >> /home/jeff/.bashrc <<CONF

# JEFF ADDED - CDPATH
CDPATH=.:\$HOME
CONF
echo " "

echo "**************************************** edit-bashrc-for-jeff.sh (END) *"
echo "************************************************************************"
echo " "