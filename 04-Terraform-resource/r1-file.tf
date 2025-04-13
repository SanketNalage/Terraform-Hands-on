# Provider Block
provider "aws" {
  profile = "default" 
  region = "eu-north-1" # This is correct for region specification
}

# Create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami           = "ami-0274f4b62b6ae3bd5" # Amazon Linux 2 AMI in eu-north-1
  instance_type = "t3.micro"

  # Corrected availability zone (must include a letter suffix)
  availability_zone = "eu-north-1a" # Changed from "eu-north-1" to "eu-north-1a"

  tags = {
    Name = "web" # This will name your instance in AWS console
    # Uncomment if you need additional tags
    # tag1 = "Update-test-1"
  }
}