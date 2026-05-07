#!/bin/sh -e
# provisioning-update-upgrade.sh

echo " "
echo "************************************************************************"
echo "******************************* provisioning-update-upgrade.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "Updating package database and upgrading"
pacman -Syu --noconfirm

echo "********************************* provisioning-update-upgrade.sh (END) *"
echo "************************************************************************"
echo " "
