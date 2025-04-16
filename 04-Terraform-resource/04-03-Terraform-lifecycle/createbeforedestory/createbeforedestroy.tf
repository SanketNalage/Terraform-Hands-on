# Create EC2 Instance
resource "aws_instance" "web" {
  ami               = "ami-0915bcb5fa77e4892" # Amazon Linux
  instance_type     = "t3.micro"
  availability_zone = "eu-north-1a"
  #availability_zone = "eu-north-1b"
  tags = {
    "Name" = "web-1"
  }
 /*
  lifecycle {
    create_before_destroy = true
  }
*/
}