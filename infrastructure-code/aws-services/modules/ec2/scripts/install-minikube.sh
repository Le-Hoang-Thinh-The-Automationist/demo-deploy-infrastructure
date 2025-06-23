#!/bin/bash

set -e

echo "[+] Updating packages..."
sudo yum update -y || sudo apt update -y

echo "[+] Installing dependencies..."
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "[-] Cannot detect OS"
    exit 1
fi

if [[ "$OS" == "amzn" ]]; then
    sudo yum install -y curl wget unzip conntrack socat
    sudo yum install -y docker
elif [[ "$OS" == "ubuntu" ]]; then
    sudo apt install -y curl wget unzip conntrack socat
    sudo apt install -y docker.io
else
    echo "[-] Unsupported OS: $OS"
    exit 1
fi

echo "[+] Starting Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "[+] Installing kubectl..."
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

echo "[+] Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

echo "[+] Adding current user to docker group..."
sudo usermod -aG docker $USER

echo "[+] Minikube and kubectl installed."
echo "[*] Run the following to apply group changes:"
echo "    newgrp docker"

echo "[*] To start Minikube, run:"
echo "    minikube start --driver=docker"
