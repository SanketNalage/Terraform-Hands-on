# Create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami                    = data.aws_ami.amzlinux
  instance_type          = var.ec2_type_instance
  key_name               = "terraform-pair"
  count = 1
  user_data = file("apache-install.sh")
  /*user_data              = <<-EOF
   
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<html><body><div>Welcome to Sanket Nalage world ! AWS Infra created using Terraform</div></body></html>" > /var/www/html/index.html
    EOF
   */
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  tags = {
    "Name" = "Terraform-Cloud-${count.index}"
  }
}