#!/bin/sh -e
# configure-move-vscode-server-settings-file-to-jeff.sh

echo " "
echo "************************************************************************"
echo "******** configure-move-vscode-server-settings-file-to-jeff.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
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

echo "chown owner to jeff:jeff"
chown jeff:jeff /home/jeff/.vscode-server/data/Machine/settings.json
echo " "

echo "********** configure-move-vscode-server-settings-file-to-jeff.sh (END) *"
echo "************************************************************************"
echo " "
