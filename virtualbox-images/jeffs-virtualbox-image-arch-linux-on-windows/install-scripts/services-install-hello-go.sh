#!/bin/sh -e
# services-install-hello-go.sh

echo " "
echo "************************************************************************"
echo "********************************* services-install-hello-go.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "Go version for user jeff"
runuser -l jeff -c "go version"
echo " "

echo "Building hello-go binary to /home/jeff/hello-go"
cd /home/jeff/services/hello-go-deploy-gce/hello-go-deploy-gce-code || exit
go build -o /home/jeff/hello-go main.go
echo " "

echo "chown hello-go to jeff:jeff..."
chown jeff:jeff /home/jeff/hello-go
echo " "

echo "ls -lat /home/jeff..."
ls -lat /home/jeff
echo " "

echo "*********************************** services-install-hello-go.sh (END) *"
echo "************************************************************************"
echo " "
