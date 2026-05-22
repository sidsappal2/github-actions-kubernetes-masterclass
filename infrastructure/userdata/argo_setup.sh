#!/bin/bash
set -e

# Set hostname
hostnamectl set-hostname "${hostname}"
echo "127.0.1.1 ${hostname}" >> /etc/hosts

# Update and install dependencies
apt-get update
apt-get install -y curl

# Install k3s (Lightweight Kubernetes)
curl -sfL https://get.k3s.io | sh -

# Wait for k3s to be ready
sleep 30

# Setup kubeconfig for ubuntu user
mkdir -p /home/ubuntu/.kube
cp /etc/rancher/k3s/k3s.yaml /home/ubuntu/.kube/config
chown -R ubuntu:ubuntu /home/ubuntu/.kube
chmod 600 /home/ubuntu/.kube/config

# Install ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Install ArgoCD CLI
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64
