variable "ami_id" {
  description = "AMI ID for the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "SSH key name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of SG IDs"
  type        = list(string)
}

variable "iam_instance_profile" {
  description = "IAM instance profile name"
  type        = string
}

variable "volume_size" {
  description = "Root volume size"
  default     = 20
}

variable "userdata_path" {
  description = "Path to the userdata script"
  type        = string
}

variable "environment" {
  description = "Environment (Production/QA)"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}
