#!/bin/sh -e
#mirror-files-to-windows.sh
#

echo "************************************************************************"
echo "* mirror-files-to-windows.sh (START) ***********************************"
echo "************************************************************************"
echo " "


echo "rsync with delete - so the file match perfectly. A mirror."
rsync -a --delete \
  ~/operations/my-packer-image-builds/virtualbox-images/jeffs-virtualbox-image-ubuntu-on-windows/ \
  /mnt/d/virtualbox/jeffs-virtualbox-image-ubuntu-on-windows/
echo " "

echo "************************************************************************"
echo "* mirror-files-to-windows.sh (END) *************************************"
echo "************************************************************************"
echo " "
