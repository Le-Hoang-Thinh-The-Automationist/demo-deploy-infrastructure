#!/bin/bash


## PART 1 - Install Docker
# Add Docker's official GPG key:
sudo apt-get update -y
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo systemctl enable docker

## PART 2 - Install Minikube
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64


## PART 3 - Add current user to be docker sudoer
echo "Checking if 'docker' group exists..."

if ! getent group docker > /dev/null; then
    echo "'docker' group does not exist. Creating..."
    sudo groupadd docker
else
    echo "'docker' group already exists."
fi

echo "Adding user $(whoami) to the 'docker' group..."
sudo usermod -aG docker $USER
sudo usermod -aG docker ubuntu

# Apply changes without reboot
newgrp docker

# Restart Docker service
sudo systemctl restart docker

echo "User $(whoami) has been granted permission to run Docker without sudo."
echo "Please log out and log back in for changes to take effect."