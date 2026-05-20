# Terraform Infrastructure for SkillPulse

This directory contains Terraform configuration to launch an AWS EC2 instance pre-configured to run the SkillPulse application using the existing project tools.

## Prerequisites

1. [Terraform](https://www.terraform.io/downloads.html) installed locally.
2. AWS CLI configured for your free-tier account.
3. An existing AWS Key Pair.

## Quick Start

1. **Initialize & Apply:**
   ```bash
   terraform init
   terraform apply
   ```
   *Note: Set `key_name` and optionally `ssh_allowed_cidr` in your `terraform.tfvars`.*

2. **SSH into the Instance:**
   ```bash
   ssh -i /path/to/your-key.pem ubuntu@<PUBLIC_IP>
   ```

## Deploying SkillPulse

The EC2 instance is automatically provisioned with Docker, Kind, Kubectl, and Make. It also includes a **4GB swap file** to allow the multi-node Kind cluster to run on the `t3.micro` instance.

Once logged in:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/trainwithshubham/github-actions-kubernetes-masterclass.git
   cd github-actions-kubernetes-masterclass
   ```

2. **Use the existing Makefile:**
   Run the "one-shot" command provided in the project:
   ```bash
   make up
   ```
   This will use the existing `k8s/kind-config.yaml` to create the cluster and deploy the application.

3. **Access the App:**
   Open `http://<EC2_PUBLIC_IP>:8888` in your browser.

## Security & Resources

- **Security:** SSH is restricted by variable (defaulting to world-open, please restrict to your IP). Only port 8888 is open for the application.
- **Free Tier:** Uses `t3.micro` and 20GB gp3 storage to stay within limits.
- **Cleanup:** Run `terraform destroy` when finished.
