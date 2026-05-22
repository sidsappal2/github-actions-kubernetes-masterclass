data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

module "kind_cluster" {
  source = "./modules/ec2"

  ami_id                 = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.skillpulse_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  userdata_path          = "${path.module}/userdata/userdata.sh"
  environment            = var.environment
  aws_region             = var.aws_region
}

module "argocd" {
  source = "./modules/ec2"

  ami_id                 = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.skillpulse_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  userdata_path          = "${path.module}/userdata/argo_setup.sh"
  environment            = var.environment
  aws_region             = var.aws_region
}

