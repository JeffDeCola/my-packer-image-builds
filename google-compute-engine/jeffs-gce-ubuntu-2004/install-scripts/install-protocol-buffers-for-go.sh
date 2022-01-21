#!/bin/bash -e
# my-packer-image-builds install-protocol-buffers-for-go.sh.sh

echo " " 
echo "************************************************************************"
echo "**************************************** install-protocol-buffers-for-go.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "Install protoc - protobuf compiler"
sudo apt-get -y install protobuf-compiler

echo "Install protoc-gen-go and protoc-gen-go-grpc binaries using golang"
echo "Should place in /home/jeff/go/bin"
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

echo "****************************************** install-protocol-buffers-for-go.sh (END) *"
echo "************************************************************************"
echo " "
