#!/bin/sh -e
# cleanup-packer-github-temp-keys.sh

echo " "
echo "************************************************************************"
echo "*************************** cleanup-packer-github-temp-keys.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "Remove the temp github private keys"
rm /home/jeff/.ssh/packer_github_temp
rm /home/jeff/.ssh/packer_github_temp.pub
echo " "

echo "***************************** cleanup-packer-github-temp-keys.sh (END) *"
echo "************************************************************************"
echo " "
