terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.94.1"
    }
  }
  backend "s3" {
    bucket = "terraform-demo-sanket"
    key = "dev/terraform.tfstate"
    region = var.aws_region
  }
}

provider "aws" {
  # Configuration options
  profile = "default"
  region  = var.aws_region # This is correct for region specification
}