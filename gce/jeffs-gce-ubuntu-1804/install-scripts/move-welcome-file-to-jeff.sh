#!/bin/bash -e
# my-packer-image-builds move-welcome-file-to-jeff.sh

echo " "
echo "************************************************************************"
echo "********************************* move-welcome-file-to-jeff.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "Switch to user jeff"
su - jeff

echo "cd /home/jeff"
cd /home/jeff
echo " "

echo "mv /tmp/welcome.txt /home/jeff"
mv /tmp/welcome.txt /home/jeff
echo " "

echo "chown owner to jeff"
chown /home/jeff/welcome.txt jeff

echo "*********************************** move-welcome-file-to-jeff.sh (END) *"
echo "************************************************************************"
echo " "