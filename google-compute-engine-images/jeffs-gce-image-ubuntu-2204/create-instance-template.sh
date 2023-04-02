#!/bin/bash -e
# my-packer-image-builds jeffs-gce-image-ubuntu-2204 create-instance-template.sh

echo " "

if [ "$1" = "-debug" ]
then
    echo "************************************************************************"
    echo "* create-instance-template.sh -debug (START) ***************************"
    echo "************************************************************************"
    # set -x enables a mode of the shell where all executed commands are printed to the terminal.
    set -x
    echo " "
else
    echo "************************************************************************"
    echo "* create-instance-template.sh (START) **********************************"
    echo "************************************************************************"
    echo " "
fi

echo "The goal is to create an instance template on gce."
echo " "

IMAGENAME=$1
PREFIX="jeffs"
SERVICE=$2
#POSTFIX=$(date -u +%Y%m%d-%H%M)

echo "gcloud compute command"
gcloud compute \
    --project "$GCP_JEFFS_PROJECT_ID" \
     instance-templates create "$PREFIX-$SERVICE-instance-template" \
    --machine-type "e2-micro" \
    --network "default" \
    --maintenance-policy "MIGRATE" \
    --tags "jeffs-firewall-settings" \
    --image "$IMAGENAME" \
    --boot-disk-size "30" \
    --boot-disk-type "pd-standard" \
    --boot-disk-device-name "$PREFIX-$SERVICE-disk" \
    --description "Instance template for Jeffs Repo my-packer-image-builds" \
    --region "us-east1" \
    # --service-account=""
    # --preemptible \
echo " "

echo "************************************************************************"
echo "* create-instance-template.sh (END) ************************************"
echo "************************************************************************"
echo " "
