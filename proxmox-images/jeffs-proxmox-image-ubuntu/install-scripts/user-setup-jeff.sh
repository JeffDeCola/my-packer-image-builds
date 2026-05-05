#!/bin/sh -e
# user-setup-jeff.sh

echo " "
echo "************************************************************************"
echo "******************************************* user-setup-jeff.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "Creating user jeff"
echo "with options:"
echo "  --disabled-password  Do not set a password (SSH key auth only)"
echo "  --gecos              Skip finger info prompts (name, phone, etc.)"
echo " "
adduser --disabled-password --gecos "" jeff
echo " "

echo "Verify jeff was created"
id jeff
echo " "

echo "Add jeff to sudo group"
usermod -aG sudo jeff
echo " "

echo " Verify jeff is in sudo group"
groups jeff
echo " "

echo "********************************************* user-setup-jeff.sh (END) *"
echo "************************************************************************"
echo " "
