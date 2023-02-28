#!/bin/sh -e
# my-packer-image-builds add-vscode-settings-json-file.sh

echo " "
echo "************************************************************************"
echo "***************************** add-vscode-settings-json-file.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "cd /home/jeff"
cd /home/jeff
echo " "

echo "mkdir /home/jeff/.vscode-server"
[ -d /home/jeff/.vscode-server ] || runuser -l jeff -c 'mkdir /home/jeff/.vscode-server'
echo " "

echo "mkdir /home/jeff/.vscode-server/data"
[ -d /home/jeff/.vscode-server/data ] || runuser -l jeff -c 'mkdir /home/jeff/.vscode-server/data'
echo " "

echo "mkdir /home/jeff/.vscode-server/data/Machine"
[ -d /home/jeff/.vscode-server/data/Machine ] || runuser -l jeff -c 'mkdir /home/jeff/.vscode-server/data/Machine'
echo " "

echo "mv /tmp/settings.json /home/jeff/.vscode-server/data/Machine"
mv /tmp/settings.json /home/jeff/.vscode-server/data/Machine
echo " "

echo "chown owner to jeff"
chown jeff /home/jeff/.vscode-server/data/Machine/settings.json
echo " "

echo "******************************* add-vscode-settings-json-file.sh (END) *"
echo "************************************************************************"
echo " "
