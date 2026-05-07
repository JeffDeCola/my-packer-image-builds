#!/bin/sh -e
# security-prepend-virtualbox-universal-key-to-authorized-keys-jeff.sh

echo " "
echo "********************************************************************************"
echo "* security-prepend-virtualbox-universal-key-to-authorized-keys-jeff.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "Make /home/jeff/.ssh if it doesn't exist"
[ -d /home/jeff/.ssh ] || mkdir /home/jeff/.ssh
echo " "

echo "chmod 700 for .ssh directory"
chmod 700 /home/jeff/.ssh
echo " "

echo "Make authorized_keys file if it doesn't exist"
[ -f /home/jeff/.ssh/authorized_keys ] || touch /home/jeff/.ssh/authorized_keys
echo " "

echo "chmod 600 for authorized_keys"
chmod 600 /home/jeff/.ssh/authorized_keys
echo " "

echo "Prepend virtualbox_universal key onto authorized_keys"
cat /tmp/virtualbox_universal.pub >> /home/jeff/.ssh/authorized_keys
echo " "

echo "Change owner to jeff:jeff"
chown jeff:jeff -R /home/jeff/.ssh
echo " "

echo "* security-prepend-virtualbox-universal-key-to-authorized-keys-jeff.sh (END) *"
echo "******************************************************************************"
echo " "
