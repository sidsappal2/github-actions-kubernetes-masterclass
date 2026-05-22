#!/bin/bash
set -e

# Set hostname
hostnamectl set-hostname "${hostname}"
echo "127.0.1.1 ${hostname}" >> /etc/hosts

# Update and install dependencies
apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common git make

# Create 4GB Swap file to handle memory constraints of t3.micro for a 3-node Kind cluster
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap sw 0 0' >> /etc/fstab

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker ubuntu

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Kind
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-amd64
chmod +x ./kind
mv ./kind /usr/local/bin/kind
