# Provider Block
provider "aws" {
  profile = "default"  
  region  = "eu-north-1"
}

# Resource Block
resource "aws_instance" "TerraformDemo" {
  ami           = "ami-0c2e61fdcb5495691"
  instance_type = var.instance_type
  tags = {
    Name = "TerraformDemo"
  }
}