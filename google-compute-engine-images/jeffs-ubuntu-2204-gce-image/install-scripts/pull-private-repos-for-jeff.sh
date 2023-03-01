#!/bin/sh -e
# my-packer-image-builds pull-private-repos-for-jeff.sh

echo " "
echo "************************************************************************"
echo "******************************* pull-private-repos-for-jeff.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "mkdir /home/jeff/development"
[ -d /home/jeff/development ] || runuser -l jeff -c 'mkdir /home/jeff/development'
echo " "

echo "git clone my-global-repo-scripts-private"
echo "You must cd into the directory in same command"
runuser -l jeff -c 'cd /home/jeff/development; git clone git@github.com:JeffDeCola/my-global-repo-scripts-private.git'
echo " "

echo "mkdir /home/jeff/crypto"
[ -d /home/jeff/crypto ] || runuser -l jeff -c 'mkdir /home/jeff/crypto'
echo " "

echo "git clone your-metasol-nft-private.git"
echo "You must cd into the directory in same command"
runuser -l jeff -c 'cd /home/jeff/crypto; git clone git@github.com:JeffDeCola/your-metasol-nft-private.git'
echo " "

# echo "Git clone all repos and set development branch (Will not get keybase secrets)"
# I would need to clean up this file - remove tput because it causes errors in gcloud
# runuser -l jeff -c 'cd /home/jeff/other/my-global-repo-scripts-private; bash clone-all-repos-and-set-develop-branch.bash'

echo "********************************* pull-private-repos-for-jeff.sh (END) *"
echo "************************************************************************"
echo " "
