#!/bin/sh -e
# my-packer-image-builds add-user-jeff.sh

echo " " 
echo "************************************************************************"
echo "********************************************* add-user-jeff.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "adduser"
echo "   --disabled-password Do not set a pssssword for the user jeff"
echo "   --gecos do not prompt for finger and password"

# I'm not sure why we don't need this - says user jeff already exists
# sudo adduser --disabled-password --gecos "" jeff

echo " "

echo "*********************************************** add-user-jeff.sh (END) *"
echo "************************************************************************"
echo " "