#!/bin/sh -e
# configure-bashrc-for-root.sh

echo " "
echo "************************************************************************"
echo "********************************* configure-bashrc-for-root.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "Add CDPATH to /root/.bashrc"
# Must escape $ with \$
cat >> /root/.bashrc <<CONF

# JEFF ADDED - CDPATH
CDPATH=.:\$HOME
CONF
echo " "

echo "*********************************** configure-bashrc-for-root.sh (END) *"
echo "************************************************************************"
echo " "
