#!/bin/sh -e
# my-packer-image-builds jeffs-virtualbox-image-ubuntu-on-windows.sh
#
# # Usage:
#   ./build-image.sh [OPTIONS]
#
# Options:
#   -v        Validate template only (no build)
#   -debug    Enable debug output (set -x)
#
# Examples:
#   ./build-image.sh              # build the image
#   ./build-image.sh -v           # validate only
#   ./build-image.sh -debug       # build with debug output

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

echo "The goal is to create a custom image on virtualbox using packer."
echo " "

echo "Initializing Packer plugins..."
packer init template.pkr.hcl
echo " "

if [ "$1" = "-v" ]
then
    echo "Validating template..."
    packer validate \
        -var "image_name=virtualbox-image-ubuntu" \
        template.pkr.hcl
else
    echo "Building image..."
    packer build -force \
        -var "image_name=virtualbox-image-ubuntu" \
        template.pkr.hcl
fi

echo "************************************************************************"
echo "* build-image.sh (END) *************************************************"
echo "************************************************************************"
echo " "
