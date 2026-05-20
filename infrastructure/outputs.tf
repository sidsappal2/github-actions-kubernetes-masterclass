output "kind_cluster_public_ip" {
  description = "Public IP of the Kind cluster instance"
  value       = aws_instance.kind_cluster.public_ip
}

output "argocd_public_ip" {
  description = "Public IP of the ArgoCD instance"
  value       = aws_instance.argocd.public_ip
}

output "kind_ssh_command" {
  description = "Command to SSH into the Kind instance"
  value       = "ssh -i skillpulse-key.pem ubuntu@${aws_instance.kind_cluster.public_ip}"
}

output "argocd_ssh_command" {
  description = "Command to SSH into the ArgoCD instance"
  value       = "ssh -i skillpulse-key.pem ubuntu@${aws_instance.argocd.public_ip}"
}
