#!/bin/sh -e
# my-packer-image-builds move-welcome-file-to-root.sh

echo " "
echo "************************************************************************"
echo "********************************* move-welcome-file-to-root.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "mv /tmp/welcome.txt /root"
mv /tmp/welcome.txt /root
echo " "

echo "*********************************** move-welcome-file-to-root.sh (END) *"
echo "************************************************************************"
echo " "