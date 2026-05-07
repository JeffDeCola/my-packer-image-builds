#!/bin/sh -e
# provisioning-run-a-dockerhub-image-at-boot.sh

echo " "
echo "************************************************************************"
echo "**************** provisioning-run-a-dockerhub-image-at-boot.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "Get the image from dockerhub and run it forever..."
docker run --name hello-go-deploy-gce -dit --restart=unless-stopped jeffdecola/hello-go-deploy-gce

echo "****************** provisioning-run-a-dockerhub-image-at-boot.sh (END) *"
echo "************************************************************************"
echo " "