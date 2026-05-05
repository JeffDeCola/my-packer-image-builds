#!/bin/sh -e
# services-enable-at-boot.sh

echo " "
echo "************************************************************************"
echo "************************************* services-enable-at-boot.sh (START)*"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "Moving hello-go.service to /lib/systemd/system/"
mv /tmp/hello-go.service /lib/systemd/system/
echo " "

echo "chmod 644 on hello-go.service"
chmod 644 /lib/systemd/system/hello-go.service
echo " "

echo "Reloading systemd daemon"
systemctl daemon-reload
echo " "

echo "Enabling and starting hello-go.service"
systemctl enable hello-go.service
systemctl start hello-go.service
echo " "

echo "*************************************** services-enable-at-boot.sh (END)*"
echo "************************************************************************"
echo " "
