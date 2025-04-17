# There will be file name Terraform.tfvars file as it will have secuirty propuse variable declared in it.
# for ex: if you have given the ec2_instance_count=1 in his file.
# Then in the Terraform.tfvars it will override that value from this file as ec2_instance_count=2

# In this we add one web.tfvars then we want to use this then we need to add
# that whie plan => terraform plan -var-file="web.tfvars" 

# Input Variables
variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type        = string
  default     = "eu-north-1"
}

variable "ec2_ami_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-0274f4b62b6ae3bd5" # Amazon2 Linux AMI ID
}

variable "ec2_instance_count" {
  description = "EC2 Instance Count"
  type        = number
  default     = 2
}

variable "ec2_type_instance" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"  # Fixed typo here
}