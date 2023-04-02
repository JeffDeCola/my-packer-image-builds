#!/bin/sh
# my-packer-image-builds service-enable-at-boot.sh

echo " "
echo "********************************************************************"
echo "******************************** service-enable-at-boot.sh (START) *" 
echo "You are root in /home/packer"
echo " "

echo "mv /tmp/hello-go.service file to /lib/systemd/system/"
mv /tmp/hello-go.service file to /lib/systemd/system/
echo " "

echo "chmod 644 on hello-go.service"
chmod 644 /lib/systemd/system/hello-go.service
echo " "

echo "systemctl enalbenablee and start hello-go.service"
systemctl daemon-reload
systemctl enable hello-go.service
systemctl start hello-go.service
echo " "

echo "************************************** service-enable-at-boot.sh (END) *"
echo "************************************************************************"
echo " "
