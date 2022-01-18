#!/bin/bash -e
# my-packer-image-builds config-go-for-jeff.sh

echo " " 
echo "************************************************************************"
echo "**************************************** config-go-for-jeff.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "Place in /home/jeff/.bashrc"
echo '
# ADD GO TO PATH
export PATH=/usr/local/go/bin:$PATH
# CDPATH
CDPATH=.:$HOME
 ' >> /home/jeff/.bashrc
echo " "

echo "****************************************** config-go-for-jeff.sh (END) *"
echo "************************************************************************"
echo " "
