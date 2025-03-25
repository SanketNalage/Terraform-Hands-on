# Provider Block
provider "aws" {
  profile = "default"  
  region  = "eu-north-1"
}

# Resource Block
resource "aws_instance" "ec2demo" {
  ami           = "ami-0c2e61fdcb5495691" # Amazon Linux in us-east-1, update as per your region
  instance_type = var.instance_type
  tags = {
    Name = "TerraformDemo"
  }
}