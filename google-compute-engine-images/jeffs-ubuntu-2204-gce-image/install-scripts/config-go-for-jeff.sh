#!/bin/sh -e
# my-packer-image-builds config-go-for-jeff.sh

echo " " 
echo "************************************************************************"
echo "**************************************** config-go-for-jeff.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "Create go environment variables and place in /home/jeff/.bashrc"
export "GOBIN=/home/jeff/go/bin"
export "PATH=/usr/local/go/bin:$PATH"
export "PATH=$GOBIN:$PATH"

echo "Also Place in /home/jeff/.bashrc"
echo '
# ADDED BY JEFF - GO TO PATH
export "GOBIN=/home/jeff/go/bin"
export "PATH=/usr/local/go/bin:$PATH"
export "PATH=$GOBIN:$PATH"
# ADDED BY JEFF - CDPATH
CDPATH=.:$HOME
 ' >> /home/jeff/.bashrc
echo " "

echo "****************************************** config-go-for-jeff.sh (END) *"
echo "************************************************************************"
echo " "
