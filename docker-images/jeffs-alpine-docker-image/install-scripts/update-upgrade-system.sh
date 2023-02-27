#!/bin/sh
# my-packer-image-builds update-upgrade-system.sh

echo " "
echo "********************************************************************"
echo "********************************* update-upgrade-system.sh (START) *" 
echo "You are root in /home/packer"
echo " "

echo "update & upgrade system"
apk update
apk upgrade
echo " "

echo "*********************************** update-upgrade-system.sh (END) *"
echo "********************************************************************"
echo " "