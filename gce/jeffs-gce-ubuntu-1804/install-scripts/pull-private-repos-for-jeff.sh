#!/bin/bash -e
# my-packer-image-builds pull-private-repos-for-jeff.sh

echo " "
echo "************************************************************************"
echo "******************************* pull-private-repos-for-jeff.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "cd into your go src directory"
cd "/home/jeff/src/github.com/JeffDeCola"
echo " "

echo "Git clone hello-go-deploy-gce"
runuser -l jeff -c 'git clone git@github.com:JeffDeCola/hello-go-deploy-gce.git'
echo " "

echo "mkdir /home/jeff/other"
[ -d /home/jeff/other ] || runuser -l jeff -c 'mkdir /home/jeff/other'
cd /home/jeff/other

echo "Git clone my-global-repo-scripts-private"
runuser -l jeff -c 'pwd'
runuser -l jeff -c 'cd /home/jeff/other'
runuser -l jeff -c 'pwd'
runuser -l jeff -c 'git clone git@github.com:JeffDeCola/my-global-repo-scripts-private.git'
echo " "

echo "********************************* pull-private-repos-for-jeff.sh (END) *"
echo "************************************************************************"
echo " "
