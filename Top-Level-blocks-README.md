# Top-Level-blocks File

## 1. Top-Level Terraform Blocks
**terraform** - Configuration for Terraform itself (backend, required providers, etc.)
```hcl
   terraform {
     required_version = "~> 1.0"
     required_providers {
       aws = {
         source  = "hashicorp/aws"
         version = "~> 4.0"
       }
     }
     backend "s3" {
       bucket = "my-terraform-state"
       key    = "prod/terraform.tfstate"
       region = "us-east-1"
     }
   }
```

## 2. provider - Configures the infrastructure provider
```hcl
provider "aws" {
  region = "us-west-2"
}
```

## 3. variable - Defines input variables
```hcl 
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}
```

## 4. locals - Defines local values
```hcl 
locals {
  common_tags = {
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}
```

## 5. data - Fetches data from external sources
```hcl
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
}
```

## 6. resource - Defines infrastructure components
```hcl
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  tags          = local.common_tags
}
```

## 7.module - Calls a child module
```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"
  # ... other VPC configurations
}
```

## 8. output - Defines output values
```hcl
output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web.public_ip
}
```

## 9. moved (Terraform 1.1+) - Handles resource migration
```hcl
moved {
  from = aws_instance.old_name
  to   = aws_instance.new_name
}
```

## 10. import (Terraform 1.5+) - Defines import blocks
```hcl 
import {
  to = aws_instance.example
  id = "i-abcd1234"
}
```