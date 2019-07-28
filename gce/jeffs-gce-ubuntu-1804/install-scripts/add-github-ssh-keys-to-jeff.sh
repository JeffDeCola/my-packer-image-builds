#!/bin/bash -e
# my-packer-image-builds add-github-ssh-keys-to-jeff.sh

echo " " 
echo "************************************************************************"
echo "******************************* add-github-ssh-keys-to-jeff.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "Switch to user jeff"
su - jeff

echo "Make /home/jeff/.ssh"
[ -d /home/jeff/.ssh ] || mkdir /home/jeff/.ssh

echo "mv /tmp/gce-github-vm* /home/jeff/.ssh"
mv /tmp/gce-github-vm /home/jeff/.ssh/id_rsa
mv /tmp/gce-github-vm.pub /home/jeff/.ssh/id_rsa.pub
echo " "

echo "chmod 600 for both keys"
chmod 600 /home/jeff/.ssh/id_rsa*

echo "chown owner to jeff"
chown /home/jeff/.ssh/id_rsa jeff
chown /home/jeff/.ssh/id_rsa.pub jeff

echo "Start ssh agent for root"
eval $(ssh-agent -s)

echo "Put github.com fingerprint in known_hosts file"
ssh-keyscan github.com >> /home/jeff/.ssh/known_hosts

echo "Add private key to SSH authentication agent"
ssh-add /home/jeff/.ssh/id_rsa

echo "Connect to github with public key (you already put public key on github)"
# The || : forces it to return a 0 exit code, because you get a warning first time connecting from a new ip.
ssh -T git@github.com || :
# ssh -i ~/.ssh/id_rsa.pub git@github.com || :
echo " "

echo "Add some github configuration"
git config --global user.name "Jeff DeCola (jeffs-gce-ubuntu-1804)"
git config --global user.email jeff@keeperlabs.com
git config --global core.editor nano
git config --global push.default simple
git config --list

echo "********************************* add-github-ssh-keys-to-jeff.sh (END) *"
echo "************************************************************************"
echo " "