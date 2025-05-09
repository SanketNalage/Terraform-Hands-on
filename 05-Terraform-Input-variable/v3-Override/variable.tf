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
  default     = 1
}

# Getting this value from the Command line value for the type will be given in the prompt 
# But there is condition that we will override in cmd
# As you can see the now t3.mrico has given then we will change while planning it
# terraform plan -var="ec2_instance_type=t3.large"

# Create Resources (optional)
# terraform apply -var="ec2_instance_type=t3.large" 

variable "ec2_type_instance" {
  description = "this is instance type"
  type = string
  default = "t3.mirco"
}