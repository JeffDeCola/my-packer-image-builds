#!/bin/sh -e
# my-packer-image-builds edit-bashrc-for-root.sh

echo " " 
echo "************************************************************************"
echo "************************************** edit-bashrc-for-root.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "Add CDPATH to /root/.bashrc"
# Must escape $ with \$
cat >> /root/.bashrc <<CONF

# JEFF ADDED - CDPATH
CDPATH=.:\$HOME
CONF
echo " "

echo "**************************************** edit-bashrc-for-root.sh (END) *"
echo "************************************************************************"
echo " "