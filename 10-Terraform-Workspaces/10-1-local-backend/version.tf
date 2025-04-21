terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.94.1"
    }
  }
  # backend "s3" {
  #   bucket = "terraform-demo-sanket"
  #   key = "statecommands/terraform.tfstate"
  #   region = "eu-north-1"

  #   # For State Locking
  #   dynamodb_table = "terraform-dev-state-table"
  # }
}

provider "aws" {
  # Configuration options
  profile = "default"
  region  = var.aws_region # This is correct for region specification
}