#!/bin/sh -e
# provisioning-install-packages.sh

echo " "
echo "************************************************************************"
echo "***************************** provisioning-install-packages.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "Installing packages..."
apt-get -q -y install \
  nano \
  net-tools \
  tmux \
  wget \
  htop \
  btop \
  git \
  unzip \
  curl \
  build-essential
echo " "

echo "******************************* provisioning-install-packages.sh (END) *"
echo "************************************************************************"
echo " "
