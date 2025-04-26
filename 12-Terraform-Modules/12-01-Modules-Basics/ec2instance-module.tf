# AWS EC2 Instance Module it taken from the terraform registry website where it have module setion
module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "my-modules-demo"
  instance_count         = 2

  ami                    = data.aws_ami.amzlinux.id
  instance_type          = "t3.micro"
  key_name               = "terraform-pair"
  monitoring             = true
  vpc_security_group_ids = ["sg-0710facdcd95aea85"]  # Get Default VPC Security Group ID and replace
  subnet_id              = "subnet-0b8913da6d1572fdb" # Get one public subnet id from default vpc and replace
  user_data               = file("apache-install.sh")

  tags = {
    Name        = "Modules-Demo"
    Terraform   = "true"
    Environment = "dev"
  }
}