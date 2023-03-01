#!/bin/sh -e
# my-packer-image-builds install-protocol-buffers-for-go.sh.sh

echo " " 
echo "************************************************************************"
echo "**************************************** install-protocol-buffers-for-go.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "Install protoc - protobuf compiler"
sudo apt-get -y install protobuf-compiler
echo " "

echo "We already did this above and placed in .bashrc, but we may need to do this again"
echo "I don't think this is useful or needed"
runuser -l jeff -c "export PATH=/usr/local/go/bin:$PATH"
runuser -l jeff -c "export PATH=/home/jeff/go/bin:$PATH"
echo " "

echo "Install protoc-gen-go and protoc-gen-go-grpc binaries using golang"
echo "Should place in /home/jeff/go/bin"
#runuser -l jeff -c 'cd /home/jeff; /usr/local/go/bin/go install google.golang.org/protobuf/cmd/protoc-gen-go@latest'
#runuser -l jeff -c 'cd /home/jeff; /usr/local/go/bin/go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest'
echo " "

echo "****************************************** install-protocol-buffers-for-go.sh (END) *"
echo "************************************************************************"
echo " "
