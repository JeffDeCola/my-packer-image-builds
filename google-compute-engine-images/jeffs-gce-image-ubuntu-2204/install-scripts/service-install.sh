#!/bin/sh
# my-packer-image-builds service-install.sh

echo " "
echo "********************************************************************"
echo "*************************************** service-install.sh (START) *" 
echo "You are root in /home/packer"
echo " "

echo "cd into /root/src/github.com/JeffDeCola/hello-go-deploy-gce/hello-go-deploy-gce-code"
cd /root/src/github.com/JeffDeCola/hello-go-deploy-gce/hello-go-deploy-gce-code || exit
echo " "

echo "Build an executable (go build), place in /root/bin"
go build -o /root/bin/hello-go main.go
echo " "

echo "********************************************* service-install.sh (END) *"
echo "************************************************************************"
echo " "
