#!/bin/sh -e
# add-proxmox-universal-ssh-keys-to-jeff.sh

echo " "
echo "************************************************************************"
echo "******************** add-proxmox-universal-ssh-keys-to-jeff.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "Make /home/jeff/.ssh"
[ -d /home/jeff/.ssh ] || mkdir /home/jeff/.ssh

echo "mv /tmp/proxmox-universal-id_rsa* /home/jeff/.ssh"
mv /tmp/proxmox-universal-id_rsa /home/jeff/.ssh/proxmox_universal_id_rsa
mv /tmp/proxmox-universal-id_rsa.pub /home/jeff/.ssh/proxmox_universal_id_rsa.pub
echo " "

echo "chmod 600 for both keys"
chmod 600 /home/jeff/.ssh/proxmox_universal_id_rsa*
echo " "

echo "Start ssh agent for root"
eval "$(ssh-agent -s)"
echo " "

echo "Add private key to SSH authentication agent"
ssh-add /home/jeff/.ssh/proxmox_universal_id_rsa
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

echo "********************** add-proxmox-universal-ssh-keys-to-jeff.sh (END) *"
echo "************************************************************************"
echo " "
