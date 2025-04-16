# Create EC2 Instance
resource "aws_instance" "web" {
  ami           = "ami-0274f4b62b6ae3bd5" # Amazon Linux
  instance_type = "t3.micro"
  count         = 5
  tags = {
    "Name" = "web"
    #"Name" = "web-${count.index}"
  }
}