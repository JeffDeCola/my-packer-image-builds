#!/bin/sh -e
# install-packages.sh

echo " "
echo "************************************************************************"
echo "********************************************* add-user-jeff.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "Installing packages..."
apt-get -qq -y install \
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

echo "******************************************** install-packages.sh (END) *"
echo "************************************************************************"
echo " "
