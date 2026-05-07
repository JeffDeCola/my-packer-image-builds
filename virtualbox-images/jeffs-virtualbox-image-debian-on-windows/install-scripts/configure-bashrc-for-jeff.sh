#!/bin/sh -e
# configure-bashrc-for-jeff.sh

echo " "
echo "************************************************************************"
echo "********************************* configure-bashrc-for-jeff.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "Add CDPATH to /home/jeff/.bashrc"
# Must escape $ with \$
cat >> /home/jeff/.bashrc <<CONF

# JEFF ADDED - CDPATH
CDPATH=.:\$HOME
CONF
echo " "

echo "*********************************** configure-bashrc-for-jeff.sh (END) *"
echo "************************************************************************"
echo " "
