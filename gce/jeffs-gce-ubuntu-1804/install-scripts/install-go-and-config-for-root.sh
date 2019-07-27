#!/bin/bash -e
# my-packer-image-builds install-go-and-config-for-root.sh

echo " " 
echo "************************************************************************"
echo "**************************** install-go-and-config-for-root.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "mkdir /tmp/go"
mkdir -p /tmp/go
echo " "

echo "Download go1.12.7 (wget quiet mode), untar and move to /usr/local"
FileName='go1.12.7.linux-amd64.tar.gz'
wget https://storage.googleapis.com/golang/$FileName
tar -xvf $FileName
sudo mv go /usr/local
rm $FileName
echo " "

echo "Create go environment variables and place in /root/.bashrc"
export GOPATH="/root"
export GOROOT="/usr/local/go"
export GOBIN=$GOPATH/bin
export PATH=$GOROOT/bin::$GOBIN:$PATH
echo 'export GOPATH="/root"
export GOROOT="/usr/local/go"
export GOBIN=$GOPATH/bin
export PATH=$GOROOT/bin::$GOBIN:$PATH
CDPATH=$CDPATH:$GOPATH/src/github.com' >> /root/.bashrc
echo " "

echo "make go directories"
mkdir -p $GOPATH/bin
mkdir -p $GOPATH/src/github.com/JeffDeCola
echo " "

echo "check version and your go env"
go version
go env
echo " "

echo "****************************** install-go-and-config-for-root.sh (END) *"
echo "************************************************************************"
echo " "
