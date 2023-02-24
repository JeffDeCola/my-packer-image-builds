#!/bin/bash -e
# my-packer-image-builds create-firewall-rule.sh

echo " "

if [ "$1" = "-debug" ]
then
    echo "************************************************************************"
    echo "* create-firewall-rule.sh -debug (START) ******************************"
    echo "************************************************************************"
    # set -x enables a mode of the shell where all executed commands are printed to the terminal.
    set -x
    echo " "
else
    echo "************************************************************************"
    echo "* create-firewall-rule.sh (START) *************************************"
    echo "************************************************************************"
    echo " "
fi

echo "The goal is to create a firewall rule."
echo " "

echo "gcloud compute command"

gcloud compute firewall-rules create jeffs-firewall-settings-rule \
    --action allow \
    --rules tcp:1234,tcp:3334 \
    --priority 1000 \
    --source-ranges 0.0.0.0/0 \
    --target-tags "jeffs-firewall-settings" \
    --description "Jeffs firewall rules"

echo ""

echo "************************************************************************"
echo "* create-firewall-rule.sh (END) ***************************************"
echo "************************************************************************"
echo " "