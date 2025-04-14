# Terraform Small Project Created

## Step-01: Introduction
- Create 9 aws resources in a step by step manner
- Create Terraform Block
- Create Provider Block
- Create 9 Resource Blocks
  - Create VPC
  - Create Subnet
  - Create Internet Gateway
  - Create Route Table
  - Create Route in Route Table for Internet Access
  - Associate Route Table with Subnet
  - Create Security Group in the VPC with port 80, 22 as inbound open
  - Create EC2 Instance in respective new vpc, new subnet created above with a static key pair, associate Security group created earlier
  - Create Elastic IP Address and Associate to EC2 Instance
  - Use `depends_on` Resource Meta-Argument attribute when creating Elastic IP  


## Step-02: versions.tf - Create Terraform & Provider Blocks 
- Create Terraform Block
- Create Provider Block
```
# Terraform Block
terraform {
  required_version = ">= 1.4" 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Provider Block
provider "aws" {
  region = "us-east-1"
  profile = "default"
}
```
### Step-03: vc-aws - Create VPC using Terraform
- Create VPC Resources listed below  
  - Create VPC
  - Create Subnet
  - Create Internet Gateway
  - Create Route Table
  - Create Route in Route Table for Internet Access
  - Associate Route Table with Subnet
  - Create Security Group in the VPC with port 80, 22 as inbound open


## Step-04: ec2-aws.tf - Create EC2 Instance Resource

## Step-05: epi-aws.tf - Create Elastic IP Resource

## Step-06: Execute Terraform commands to Create Resources using Terraform
```
# Initialize Terraform
terraform init

# Terraform Validate
terraform validate

# Terraform Plan to Verify what it is going to create / update / destroy
terraform plan

# Terraform Apply to Create EC2 Instance
terraform apply 
```

## Step-07: Verify the Resources
- Verify VPC
- Verify EC2 Instance
- Verify Elastic IP
- Review the `terraform.tfstate` file
- Access Apache Webserver Static page using Elastic IP

## Step-09: Destroy Terraform Resources
```
# Destroy Terraform Resources
terraform destroy

# Remove Terraform Files
rm -rf .terraform*
rm -rf terraform.tfstate*
```


## References 
- [Elastic IP creation depends on VPC Internet Gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip)
- [Resource: aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)
- [Resource: aws_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)
- [Resource: aws_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)
- [Resource: aws_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)
- [Resource: aws_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route)
- [Resource: aws_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association)
- [Resource: aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)
- [Resource: aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
- [Resource: aws_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip)