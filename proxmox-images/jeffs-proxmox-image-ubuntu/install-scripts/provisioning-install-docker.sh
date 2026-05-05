#!/bin/sh -e
# provisioning-install-docker.sh

echo " "
echo "************************************************************************"
echo "******************************* provisioning-install-docker.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

echo "*** PART I - SET UP THE REPOSITORY"
echo " "

echo "Update apt cache before installing prerequisites"
sudo apt-get -y update
echo " "

echo "Install a few prerequisite packages"
apt-get -y install \
    ca-certificates \
    curl \
    gnupg
echo " "

echo "Install a few prerequisite packages"
    apt-get -y install \
    ca-certificates \
    curl \
    gnupg
echo " "

echo "Add Docker's official GPG key:"
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo " "

echo "Set up the repository:"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
echo " "

echo "*** PART II - INSTALL DOCKER ENGINE"
echo " "

echo "Update the package database with the Docker packages from the newly added repo"
apt-get -y update
echo " "

echo "Install Docker Engine, containerd, and Docker Compose"
apt-get -y install \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin
echo " "

echo "Check that it will run at boot"
systemctl is-enabled docker
echo " "

echo "Add user jeff to docker group"
usermod -aG docker jeff
echo " "

echo "********************************* provisioning-install-docker.sh (END) *"
echo "************************************************************************"
echo " "
