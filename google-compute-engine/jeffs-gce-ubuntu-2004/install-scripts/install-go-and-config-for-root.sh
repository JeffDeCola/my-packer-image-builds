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

echo "Download go1.17.6 (wget quiet mode), untar and move to /usr/local"
FileName='go1.17.6.linux-amd64.tar.gz'
wget -q https://go.dev/dl/$FileName
tar -xf $FileName
sudo mv go /usr/local
rm $FileName
echo " "

echo "Place in /root/.bashrc"
echo '
# CDPATH
CDPATH=.:$HOME
 ' >> /root/.bashrc
echo " "

echo "check version and your go env"
go version
go env
echo " "

echo "****************************** install-go-and-config-for-root.sh (END) *"
echo "************************************************************************"
echo " "
