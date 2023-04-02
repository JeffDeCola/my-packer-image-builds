#!/bin/sh
# my-packer-image-builds service-install.sh

echo " "
echo "********************************************************************"
echo "*************************************** service-install.sh (START) *" 
echo "You are root in /home/packer"
echo " "

echo "cd /home/jeff/services/hello-go-deploy-gce/hello-go-deploy-gce-code"
cd /home/jeff/services/hello-go-deploy-gce/hello-go-deploy-gce-code || exit
echo " "

echo "ls -lat"
ls -lat
echo " "

echo "Build an executable (go build), place in /bin"
go build -o /usr/bin/hello-go main.go
echo " "

echo "ls -lat /usr/bin | grep hello"
ls -lat /usr/bin | grep hello
echo " "

echo "********************************************* service-install.sh (END) *"
echo "************************************************************************"
echo " "
