#!/bin/sh -e
# provisioning-run-a-dockerhub-image-at-boot.sh

echo " "
echo "************************************************************************"
echo "**************** provisioning-run-a-dockerhub-image-at-boot.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "Get the image from dockerhub and run it forever - name the container hello-go"
# docker pull jeffdecola/hello-go-deploy-gce
# docker run jeffdecola/hello-go-deploy-gce
# -name                         names the docker container
# -d                            run in background
# -i                            keep stdin open
# -t                            allocate a terminal
# --restart=unless-stopped      it will always run
docker run --name hello-go-deploy-gce -dit --restart=unless-stopped jeffdecola/hello-go-deploy-gce
echo " "

echo "****************** provisioning-run-a-dockerhub-image-at-boot.sh (END) *"
echo "************************************************************************"
echo " "