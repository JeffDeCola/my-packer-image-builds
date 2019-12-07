#!/bin/bash -e
# my-packer-image-builds pull-private-repos-for-jeff.sh

echo " "
echo "************************************************************************"
echo "******************************* pull-private-repos-for-jeff.sh (START) *"
echo "You are root in /home/packer"
echo " "

# echo "Git clone hello-go-deploy-gce"
# echo "You must cd into the directory in same command"
# runuser -l jeff -c 'cd /home/jeff/src/github.com/JeffDeCola; git clone git@github.com:JeffDeCola/hello-go-deploy-gce.git'
# echo " "

echo "mkdir /home/jeff/other"
[ -d /home/jeff/other ] || runuser -l jeff -c 'mkdir /home/jeff/other'

echo "Git clone my-global-repo-scripts-private"
echo "You must cd into the directory in same command"
runuser -l jeff -c 'cd /home/jeff/other; git clone git@github.com:JeffDeCola/my-global-repo-scripts-private.git'
echo " "

# echo "Git clone all repos and set development branch (Will not get keybase secrets)"
# runuser -l jeff -c 'cd /home/jeff/other/my-global-repo-scripts-private; bash clone-all-repos-and-set-develop-branch.bash'

echo "********************************* pull-private-repos-for-jeff.sh (END) *"
echo "************************************************************************"
echo " "
