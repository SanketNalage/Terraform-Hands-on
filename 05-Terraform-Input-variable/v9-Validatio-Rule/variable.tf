# Validation for the ami one  
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
  validation {
    condition = length(var.ec2_ami_id) > 4 && substr(var.ec2_ami_id, 0, 4) == "ami-"
    error_message = "The ec2_ami_id value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "ec2_instance_count" {
  description = "EC2 Instance Count"
  type        = number
  default     = 2
}

variable "ec2_type_instance" {
  description = "EC2 instance type"
  type = map(string)
  default = {
    "small-apps" = "t3.micro"
    "medium-apps" = "t3.medium" 
    "big-apps" = "t3.large"    
  }
}