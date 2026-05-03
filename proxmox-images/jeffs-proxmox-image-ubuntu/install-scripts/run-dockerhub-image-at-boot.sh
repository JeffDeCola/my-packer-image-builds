#!/bin/sh -e
# run-dockerhub-image-at-boot.sh

echo " "
echo "************************************************************************"
echo "********************************************* add-user-jeff.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "Get the image from dockerhub and run it forever - name the container hello-go"
# docker pull jeffdecola/hello-go-deploy-gce
# docker run jeffdecola/hello-go-deploy-gce
# -name names the docker container
# -restart unless stopped, means it will always run
docker run --name hello-go-deploy-gce -dit --restart unless-stopped jeffdecola/hello-go-deploy-gce
echo " "

echo "********************************* run-dockerhub-image-at-boot.sh (END) *"
echo "************************************************************************"
echo " "