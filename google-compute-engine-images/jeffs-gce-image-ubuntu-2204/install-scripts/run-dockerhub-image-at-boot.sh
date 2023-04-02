#!/bin/sh -e
# my-packer-image-builds jeffs-gce-image-ubuntu-2204 run-dockerhub-image-at-boothub-image.sh

echo " " 
echo "************************************************************************"
echo "********************** run-dockerhub-image-at-boothub-image.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "Get the image from dockerhub and run it forever - name the container hello-go"
# docker pull jeffdecola/hello-go-deploy-gce
# docker run jeffdecola/hello-go-deploy-gce
# -name names the docker container
# -restart unless stopped, means it will always run
docker run --name hello-go-deploy-gce -dit --restart unless-stopped jeffdecola/hello-go-deploy-gce
echo " "

echo "************************ run-dockerhub-image-at-boothub-image.sh (END) *"
echo "************************************************************************"
echo " "