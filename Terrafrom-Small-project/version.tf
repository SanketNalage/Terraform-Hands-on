terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.94.1"
    }
  }
}

provider "aws" {
  # Configuration options
  profile = "default"
  region  = "eu-north-1" # This is correct for region specification
}