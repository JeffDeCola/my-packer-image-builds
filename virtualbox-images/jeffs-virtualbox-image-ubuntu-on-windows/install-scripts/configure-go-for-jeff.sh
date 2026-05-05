#!/bin/sh -e
# configure-go-for-jeff.sh

echo " "
echo "************************************************************************"
echo "************************************* configure-go-for-jeff.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "Add this to /home/jeff/.bashrc"
# Must escape $ with \$
cat >> /home/jeff/.bashrc <<CONF

# JEFF ADDED - FOR GOLANG
export PATH=\$PATH:/usr/local/go/bin
export GOBIN=/home/jeff/go/bin
export PATH=\$PATH:\$GOBIN
CONF
echo " "

echo "Checking go version for jeff"
runuser -l jeff -c "/usr/local/go/bin/go version"
echo " "

echo "Checking go env for jeff"
runuser -l jeff -c "/usr/local/go/bin/go env"
echo " "

echo "*************************************** configure-go-for-jeff.sh (END) *"
echo "************************************************************************"
echo " "
