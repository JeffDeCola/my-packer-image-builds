#!/bin/sh -e
# my-packer-image-builds jeffs-gce-image-ubuntu-2204 build-image.sh

echo " "

if [ "$1" = "-debug" ]
then
    echo "************************************************************************"
    echo "* build-image.sh -debug (START) ****************************************"
    echo "************************************************************************"
    # set -x enables a mode of the shell where all executed commands are printed to the terminal.
    set -x
    echo " "
else
    echo "************************************************************************"
    echo "* build-image.sh (START) ***********************************************"
    echo "************************************************************************"
    echo " "
fi

echo "The goal is to create a custom image on gce using packer."
echo " "

echo "Check for -v switch"
if [ "$1" = "-v" ]
then
    echo "Validate this file"
    command="validate"
else
    echo "Not validating - Lets build the image"
    command="build -force"
fi
echo " "

echo "packer build command"
packer $command \
    -var "image_name=gce-ubuntu-2204" \
    -var "account_file=$GCP_JEFFS_SERVICE_ACCOUNT_PATH" \
    -var "project_id=$GCP_JEFFS_PROJECT_ID" \
    template.pkr.hcl
echo " "

echo "************************************************************************"
echo "* build-image.sh (END) *************************************************"
echo "************************************************************************"
echo " "
