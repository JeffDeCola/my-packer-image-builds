#!/bin/sh -e
# cp-files-to-windows.sh
#

echo "************************************************************************"
echo "* cp-files-to-windows.sh (START) ***************************************"
echo "************************************************************************"
echo " "


echo "Copying all files to windows so you can use them in your packer builds."
cp -r ~/operations/my-packer-image-builds/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows /mnt/d/virtualbox/
echo " "

echo "************************************************************************"
echo "* cp-files-to-windows.sh (END) *****************************************"
echo "************************************************************************"
echo " "
