#!/bin/sh -e
# my-packer-image-builds jeffs-gce-image-ubuntu-2204 add-gce-universal-ssh-keys-to-jeff.sh

echo " " 
echo "************************************************************************"
echo "************************ add-gce-universal-ssh-keys-to-jeff.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "Make /home/jeff/.ssh"
[ -d /home/jeff/.ssh ] || mkdir /home/jeff/.ssh

echo "mv /tmp/gce-github-vm* /root/.ssh"
mv /tmp/gce-universal-key-for-all-vms /home/jeff/.ssh/gce_universal_id_rsa
mv /tmp/gce-universal-key-for-all-vms.pub /home/jeff/.ssh/gce_universal_id_rsa.pub
echo " "

echo "chmod 600 for both keys"
chmod 600 /home/jeff/.ssh/gce_universal_id_rsa*
echo " "

echo "Start ssh agent for root"
eval "$(ssh-agent -s)"
echo " "

echo "Add private key to SSH authentication agent"
ssh-add /home/jeff/.ssh/gce_universal_id_rsa
echo " "

echo "Make authorized_keys if it doesn't exist"
echo "Make /home/jeff/authorized_keys"
[ -d /home/jeff/.ssh/authorized_keys ] || touch /home/jeff/.ssh/authorized_keys
echo " "

echo "chmod 600 for authorized_keys"
chmod 600 /home/jeff/.ssh/authorized_keys
echo " "

echo "cat id_rsa.pub onto the authorized_keys"
cat /home/jeff/.ssh/gce_universal_id_rsa.pub >> /home/jeff/.ssh/authorized_keys
echo " "

echo "Change owner to jeff"
sudo chown jeff -R /home/jeff/.ssh
echo " "

echo "************************** add-gce-universal-ssh-keys-to-jeff.sh (END) *"
echo "************************************************************************"
echo " "
