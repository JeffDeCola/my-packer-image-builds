#!/bin/bash -e
# my-packer-image-builds pull-private-repos-for-jeff.sh

echo " "
echo "************************************************************************"
echo "********************** pull-private-repos-for-jeff-for-jeff.sh (START) *"
echo "You are root in /home/packer"
echo " "

export GOPATH="/home/jeff"
export GOROOT="/usr/local/go"
export GOBIN=$GOPATH/bin
export PATH=$GOROOT/bin::$GOBIN:$PATH

echo "cd into your go src directory"
cd "$GOPATH/src/github.com/JeffDeCola"
echo " "

echo "Git clone any public or private repo"
git clone git@github.com:JeffDeCola/hellog-go-deploy-gce
echo " "

echo "************************ pull-private-repos-for-jeff-for-jeff.sh (END) *"
echo "************************************************************************"
echo " "
