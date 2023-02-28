#!/bin/sh -e
# my-packer-image-builds config-go-for-jeff.sh

echo " " 
echo "************************************************************************"
echo "**************************************** config-go-for-jeff.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "Create go environment variables and place in /home/jeff/.bashrc"
export "PATH=$PATH:/usr/local/go/bin"
export "GOBIN=/home/jeff/go/bin"
export "PATH=$PATH:$GOBIN"
echo " "

echo "Add this to /home/jeff/.bashrc"
# Must escape $ with \$
cat >> /home/jeff/.bashrc <<CONF

# JEFF ADDED - FOR GOLANG
export PATH=\$PATH:/usr/local/go/bin
export GOBIN=/home/jeff/go/bin
export PATH=\$PATH:\$GOBIN
CONF
echo " "

echo "****************************************** config-go-for-jeff.sh (END) *"
echo "************************************************************************"
echo " "
