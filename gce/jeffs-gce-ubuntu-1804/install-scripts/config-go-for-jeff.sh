#!/bin/bash -e
# my-packer-image-builds config-go-for-jeff.sh

echo " " 
echo "************************************************************************"
echo "**************************************** config-go-for-jeff.sh (START) *"
echo "You are root in /home/packer"
echo " "


echo "Create go environment variables and place in /home/jeff/.bashrc"
export GOPATH="/home/jeff"
export GOROOT="/usr/local/go"
export GOBIN=$GOPATH/bin
export PATH=$GOROOT/bin::$GOBIN:$PATH
echo 'export GOPATH="/home/jeff"
export GOROOT="/usr/local/go"
export GOBIN=$GOPATH/bin
export PATH=$GOROOT/bin::$GOBIN:$PATH
CDPATH=$CDPATH:$GOPATH/src/github.com' >> /home/jeff/.bashrc
echo " "

echo "make go directories"
mkdir -p $GOPATH/bin
mkdir -p $GOPATH/src/github.com/JeffDeCola
echo " "

echo "check version and your go env"
go version
go env
echo " "

echo "****************************************** config-go-for-jeff.sh (END) *"
echo "************************************************************************"
echo " "
