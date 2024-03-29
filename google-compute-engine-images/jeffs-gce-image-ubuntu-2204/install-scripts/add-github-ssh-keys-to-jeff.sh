#!/bin/sh -e
# my-packer-image-builds jeffs-gce-image-ubuntu-2204 add-github-ssh-keys-to-jeff.sh

echo " " 
echo "************************************************************************"
echo "******************************* add-github-ssh-keys-to-jeff.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "Make /home/jeff/.ssh"
[ -d /home/jeff/.ssh ] || mkdir /home/jeff/.ssh
echo " "

echo "chown owner to jeff"
chown jeff /home/jeff/.ssh
echo " "

echo "mv /tmp/gce-github-vm* /home/jeff/.ssh"
mv /tmp/gce-github-vm /home/jeff/.ssh/id_rsa
mv /tmp/gce-github-vm.pub /home/jeff/.ssh/id_rsa.pub
echo " "

echo "chmod 600 for both keys"
chmod 600 /home/jeff/.ssh/id_rsa*
echo " "

echo "chown owner to jeff"
chown jeff /home/jeff/.ssh/id_rsa
chown jeff /home/jeff/.ssh/id_rsa.pub
echo " "

echo "Start ssh agent for root"
eval "$(ssh-agent -s)"

echo "Put github.com fingerprint in known_hosts file"
runuser -l jeff -c 'ssh-keyscan github.com >> /home/jeff/.ssh/known_hosts'
echo " "

echo "Add private key to SSH authentication agent"
ssh-add /home/jeff/.ssh/id_rsa
echo " "

echo "Connect to github with public key (you already put public key on github)"
# The || : forces it to return a 0 exit code, because you get a warning first time connecting from a new ip.
runuser -l jeff -c 'ssh -T git@github.com || :'
# ssh -i ~/.ssh/id_rsa.pub git@github.com || :
echo " "

echo "Add some github configuration"
runuser -l jeff -c 'git config --global user.name "Jeff DeCola (jeffs-gce-ubuntu-2004)"'
runuser -l jeff -c 'git config --global user.email jeff@keeperlabs.com'
runuser -l jeff -c 'git config --global core.editor nano'
runuser -l jeff -c 'git config --global push.default simple'
runuser -l jeff -c 'git config --list'
echo " "

echo "********************************* add-github-ssh-keys-to-jeff.sh (END) *"
echo "************************************************************************"
echo " "