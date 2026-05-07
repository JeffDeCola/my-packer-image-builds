#!/bin/sh -e
# configure-git-for-jeff.sh

echo " "
echo "************************************************************************"
echo "************************************ configure-git-for-jeff.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "Add git configuration for jeff..."
runuser -l jeff -c 'git config --global user.name "Jeff DeCola (jeffs-virtualbox-image-arch-linux-on-windows)"'
runuser -l jeff -c 'git config --global user.email jeffdecola@gmail.com'
runuser -l jeff -c 'git config --global core.editor nano'
runuser -l jeff -c 'git config --global push.default simple'
echo " "

echo "Verify git configuration..."
runuser -l jeff -c 'git config --list'
echo " "

echo "************************************** configure-git-for-jeff.sh (END) *"
echo "************************************************************************"
echo " "
