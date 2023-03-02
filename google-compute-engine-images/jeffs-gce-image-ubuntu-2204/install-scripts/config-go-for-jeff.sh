#!/bin/sh -e
# my-packer-image-builds jeffs-gce-image-ubuntu-2204 config-go-for-jeff.sh

echo " " 
echo "************************************************************************"
echo "**************************************** config-go-for-jeff.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "Create go environment variables and place in /home/jeff/.bashrc"
echo "I don;t think this is useful or needed"
runuser -l jeff -c "export PATH=$PATH:/usr/local/go/bin"
runuser -l jeff -c "export GOBIN=/home/jeff/go/bin"
runuser -l jeff -c "export PATH=$PATH:$GOBIN"
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

echo "Check go version and your go env"
#runuser -l jeff -c "/usr/local/go/bin/go version"
#runuser -l jeff -c "/usr/local/go/bin/go env"
echo " "

echo "****************************************** config-go-for-jeff.sh (END) *"
echo "************************************************************************"
echo " "
