#!/bin/sh -e
# my-packer-image-builds jeffs-gce-image-ubuntu-2204 add-github-ssh-keys-to-root.sh

echo " " 
echo "************************************************************************"
echo "******************************* add-github-ssh-keys-to-root.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "Make /root/.ssh"
[ -d /root/.ssh ] || mkdir /root/.ssh
echo " "

echo "mv /tmp/gce-github-vm* /root/.ssh"
cp /tmp/gce-github-vm /root/.ssh/id_rsa
cp /tmp/gce-github-vm.pub /root/.ssh/id_rsa.pub
echo " "

echo "chmod 600 for both keys"
chmod 600 /root/.ssh/id_rsa*
echo " "

echo "Start ssh agent for root"
eval "$(ssh-agent -s)"
echo " "

echo "Put github.com fingerprint in known_hosts file"
ssh-keyscan github.com >> /root/.ssh/known_hosts
echo " "

echo "Add private key to SSH authentication agent"
ssh-add /root/.ssh/id_rsa
echo " "

echo "Connect to github with public key (you already put public key on github)"
# The || : forces it to return a 0 exit code, because you get a warning first time connecting from a new ip.
ssh -T git@github.com || :
# ssh -i ~/.ssh/id_rsa.pub git@github.com || :
echo " "

echo "********************************* add-github-ssh-keys-to-root.sh (END) *"
echo "************************************************************************"
echo " "