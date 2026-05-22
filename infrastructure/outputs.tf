output "kind_cluster_public_ip" {
  description = "Public IP of the Kind cluster instance"
  value       = module.kind_cluster.public_ip
}

output "argocd_public_ip" {
  description = "Public IP of the ArgoCD instance"
  value       = module.argocd.public_ip
}

output "kind_cluster_hostname" {
  description = "Hostname of the Kind cluster instance"
  value       = module.kind_cluster.hostname
}

output "argocd_hostname" {
  description = "Hostname of the ArgoCD instance"
  value       = module.argocd.hostname
}

output "kind_ssh_command" {
  description = "Command to SSH into the Kind instance"
  value       = "ssh -i ${var.key_name}.pem ubuntu@${module.kind_cluster.public_ip}"
}

output "argocd_ssh_command" {
  description = "Command to SSH into the ArgoCD instance"
  value       = "ssh -i ${var.key_name}.pem ubuntu@${module.argocd.public_ip}"
}

