#Create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami                    = "ami-0274f4b62b6ae3bd5"
  instance_type          = "t3.micro"
  key_name               = "terraform-pair"
  subnet_id              = aws_subnet.vpc-dev-public-subnet-1.id
  vpc_security_group_ids = [aws_security_group.dev-vpc-sg.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<h1>Welcome to StackSimplify ! AWS Infra created using Terraform in us-east-1 Region</h1>" > /var/www/html/index.html
  EOF
  tags = {
    "Name" = "EC2-demo-terraform"
  }

}