resource "random_integer" "hostname_suffix" {
  min = 100
  max = 999
}

locals {
  region_codes = {
    "us-east-1"      = "USE1"
    "us-east-2"      = "USE2"
    "us-west-1"      = "USW1"
    "us-west-2"      = "USW2"
    "eu-central-1"   = "EUC1"
    "eu-west-1"      = "EUW1"
    "ap-southeast-1" = "APS1"
  }

  env_codes = {
    "Production" = "P"
    "QA"         = "Q"
  }

  region_code = lookup(local.region_codes, var.aws_region, "UNK")
  env_code    = lookup(local.env_codes, var.environment, "X")
  hostname    = "${local.region_code}${local.env_code}${random_integer.hostname_suffix.result}"
}

resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  iam_instance_profile   = var.iam_instance_profile

  root_block_device {
    volume_size = var.volume_size
    volume_type = "gp3"
  }

  user_data = templatefile(var.userdata_path, {
    hostname = local.hostname
  })

  tags = {
    Name = local.hostname
  }
}
