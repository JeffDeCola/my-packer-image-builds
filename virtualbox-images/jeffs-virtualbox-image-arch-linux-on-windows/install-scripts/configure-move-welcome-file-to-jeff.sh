#!/bin/sh -e
# configure-move-welcome-file-to-jeff.sh

echo " "
echo "************************************************************************"
echo "*********************** configure-move-welcome-file-to-jeff.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "cd /home/jeff"
cd /home/jeff
echo " "

echo "ls -lat /tmp"
ls -lat /tmp
echo " "

echo "mv /tmp/welcome.txt /home/jeff"
mv /tmp/welcome.txt /home/jeff
echo " "

echo "chown owner to jeff"
chown jeff:jeff /home/jeff/welcome.txt
echo " "

echo "************************* configure-move-welcome-file-to-jeff.sh (END) *"
echo "************************************************************************"
echo " "
