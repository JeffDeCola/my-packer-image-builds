#!/bin/sh -e
# my-packer-image-builds install-docker.sh

echo " " 
echo "************************************************************************"
echo "******************************************** install-docker.sh (START) *"
echo "You are root in /home/packer"
echo " "

echo "*** PART I - SET UP THE REPOSITORY"
echo " "

echo "Install a few prerequisite packages"
sudo apt-get -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
echo " "

echo "Add Docker’s official GPG key:"
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo " "

echo "Set up the repository:"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo " "

echo "*** PART II - INSTALL DOCKER ENGINE"
echo " "

echo "Update the package database with the Docker packages from the newly added repo"
sudo apt-get -y update
echo " "

echo "Install Docker Engine, containerd, and Docker Compose"
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo " "

echo "Check that it will run at boot"
systemctl status docker
echo " "

echo "Create docker group"
# For some reason I think this group already exists now
sudo groupadd docker

echo "Add user jeff to docker group"
sudo usermod -aG docker jeff
echo " "

echo "********************************************** install-docker.sh (END) *"
echo "************************************************************************"
echo " "