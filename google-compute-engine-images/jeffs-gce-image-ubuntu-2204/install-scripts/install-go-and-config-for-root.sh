#!/bin/sh -e
# my-packer-image-builds jeffs-gce-image-ubuntu-2204 install-go-and-config-for-root.sh

echo " " 
echo "************************************************************************"
echo "**************************** install-go-and-config-for-root.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "mkdir /tmp/go"
mkdir -p /tmp/go
echo " "

echo "Download go1.20.1 (wget quiet mode), untar and move to /usr/local"
FileName='go1.20.1.linux-amd64.tar.gz'
wget -q https://go.dev/dl/$FileName
tar -xf $FileName
sudo mv go /usr/local
rm $FileName
echo " "

echo "Create go environment variables and place in /root/.bashrc"
export "GOBIN=/root/go/bin"
export "PATH=/usr/local/go/bin:$PATH"
export "PATH=$GOBIN:$PATH"
echo " "

echo "Add to /root/.bashrc"
# Must escape $ with \$
cat >> /root/.bashrc <<CONF

# JEFF ADDED - FOR GOLANG
export "GOBIN=/root/go/bin"
export "PATH=/usr/local/go/bin:$PATH"
export "PATH=$GOBIN:$PATH"
CONF
echo " "

echo "Check go version and your go env"
go version
go env
echo " "

echo "****************************** install-go-and-config-for-root.sh (END) *"
echo "************************************************************************"
echo " "
