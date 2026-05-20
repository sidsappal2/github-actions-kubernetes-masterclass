terraform {
  backend "s3" {
    bucket         = "skillpulse-tf-state-669890778583"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "skillpulse-tf-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}
