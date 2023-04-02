#!/bin/bash -e
# my-packer-image-builds jeffs-gce-image-ubuntu-2204 create-instance-group.sh

echo " "

if [ "$1" = "-debug" ]
then
    echo "************************************************************************"
    echo "* create-instance-group.sh -debug (START) ******************************"
    echo "************************************************************************"
    # set -x enables a mode of the shell where all executed commands are printed to the terminal.
    set -x
    echo " "
else
    echo "************************************************************************"
    echo "* create-instance-group.sh (START) *************************************"
    echo "************************************************************************"
    echo " "
fi

echo "The goal is to create a managed instance group on gce."
echo " "

TEMPLATENAME=$1
PREFIX="jeffs"
SERVICE=$2

echo "gcloud compute command"
gcloud compute \
    --project "$GCP_JEFFS_PROJECT_ID" \
    instance-groups managed create "$PREFIX-$SERVICE-instance-group" \
    --size "1" \
    --template "$TEMPLATENAME" \
    --base-instance-name "$PREFIX-$SERVICE-instance" \
    --zone "us-east1-b" \
    --description "Instance Group for Jeffs Repo hello-go-deploy-gce"
echo ""

echo "************************************************************************"
echo "* create-instance-group.sh (END) ***************************************"
echo "************************************************************************"
echo " "
