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
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.30.0/kind-linux-amd64
chmod +x ./kind
mv ./kind /usr/local/bin/kind

# Create Kind Cluster
# We wait for docker to be ready
sleep 10
cat <<EOF > /tmp/kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: skillpulse
nodes:
  - role: control-plane
    image: kindest/node:v1.35.1
    extraPortMappings:
      - containerPort: 30080
        hostPort: 8888
        protocol: TCP
  - role: worker
    image: kindest/node:v1.35.1
  - role: worker
    image: kindest/node:v1.35.1
EOF

kind create cluster --config /tmp/kind-config.yaml

# Setup kubeconfig for ubuntu user
mkdir -p /home/ubuntu/.kube
kind get kubeconfig --name skillpulse > /home/ubuntu/.kube/config
chown -R ubuntu:ubuntu /home/ubuntu/.kube
chmod 600 /home/ubuntu/.kube/config
