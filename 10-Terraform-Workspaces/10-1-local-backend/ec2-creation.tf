# Create EC2 Instance - Amazon Linux
resource "aws_instance" "my-ec2-vm" {
  ami           = data.aws_ami.amzlinux.id 
  instance_type = var.ec2_type_instance
  #instance_type = "t2.micro"
  key_name      = "terraform-pair"
  count = terraform.workspace == "default" ? 2 : 1 
	user_data = file("apache-install.sh")  
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  tags = {
    "Name" = "vm-${terraform.workspace}-${count.index}"
    #"demotag" = "refreshtest"  # Enable during Step-04-05
    #"target" = "Target-Test-1" # Enable during step-08
  }
}

/*
# Enable during step-08
# New VM
resource "aws_instance" "my-demo-vm" {
  ami           = data.aws_ami.amzlinux.id 
  instance_type = var.instance_type
  tags = {
    "Name" = "demo-vm1"
  }
}
*/


