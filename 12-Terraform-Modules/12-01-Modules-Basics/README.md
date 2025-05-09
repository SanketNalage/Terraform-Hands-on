# Terraform Module Basics

## Step-01: Introduction
1. Introduction - Module Basics  
  - Root Module
  - Child Module
  - Published Modules (Terraform Registry)

2. Module Basics 
  - Defining a Child Module
    - Source (Mandatory)
    - Version
    - Meta-arguments (count, for_each, providers, depends_on, )
    - Accessing Module Output Values
    - Tainting resources within a module

## Step-02: Defining a Child Module
- We need to understand about the following
  - Module Source (Mandatory): To start with we will use Terraform Registry
  - Module Version (Optional): Recommended to use module version
- Create a simple EC2 Instance module
  - versions.tf: standard
  - variables.tf: standard
  - ami-datasource.tf: standard
  - ec2instance-module.tf: We will focus on building this template  
```t
# AWS EC2 Instance Module

module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "my-modules-demo"
  instance_count         = 2

  ami                    = data.aws_ami.amzlinux.id
  instance_type          = "t3.micro"
  key_name               = "terraform-pair"
  monitoring             = true
  vpc_security_group_ids = ["sg-08b25c5a5bf489ffa"]  # Get Default VPC Security Group ID and replace
  subnet_id              = "subnet-4ee95470" # Get one public subnet id from default vpc and replace
  user_data               = file("apache-install.sh")

  tags = {
    Name        = "Modules-Demo"
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Step-03: Define Outputs from a EC2 Instance Module
- c5-outputs.tf: We will output the EC2 Instance Module attributes (Public DNS and Public IP)
```t
# Output variable definitions

output "ec2_instance_public_ip" {
  description = "Public IP addresses of EC2 instances"
  value       = module.ec2_cluster.*.public_ip
}

output "ec2_instance_public_dns" {
  description = "Public IP addresses of EC2 instances"
  value       = module.ec2_cluster.*.public_dns
}
```

## Step-04: Execute Terraform Commands
```t
# Terraform Init
terraform init

# Terraform Validate
terraform validate

# Terraform Format
terraform fmt

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-apporve

# Verify 
1) Verify in AWS management console , if EC2 Instances got created.
2) Update default security group of a VPC to allow port 80 from internet
3) Access Apache Webserver
http://<Public-IP-VM1>
http://<Public-IP-VM2>
```

## Step-05: Tainting Resources in a Module
- The **taint command** can be used to taint specific resources within a module
- **Very Very Important Note:** It is not possible to taint an entire module. Instead, each resource within the module must be tainted separately.
```t
# List Resources from State
terraform state list

# Taint a Resource
terraform taint <RESOURCE-NAME>
terraform taint module.ec2_cluster.aws_instance.this[0]

# Terraform Plan
terraform plan
Observation: First VM will be destroyed and re-created

# Terraform Apply
terraform apply -auto-approve
```

## Step-06: Clean-Up Resources & local working directory
```t
# Terraform Destroy
terraform destroy -auto-approve

# Delete Terraform files 
rm -rf .terraform*
rm -rf terraform.tfstate*
```

## Step-07: Meta-Arguments for Modules
- Meta-Argument concepts are going to be same as how we learned during Resources section.
  - count
  - for_each
  - providers
  - depends_on
- [Meta-Arguments for Modules](https://www.terraform.io/docs/language/modules/syntax.html#meta-arguments)


## Step-08: Upgrade Terraform Module from v2.x to v5.x
- **Terraform Manifests Folder:** terraform-manifests-upgraded
- **File:** c4-ec2instance-module.tf
```t
# AWS EC2 Instance Module
module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 5.0"

  name                   = "my-modules-demo"

  ami                    = data.aws_ami.amzlinux.id 
  instance_type          = "t2.micro"
  key_name               = "terraform-key"
  monitoring             = true
  vpc_security_group_ids = ["sg-b8406afc"] # Get Default VPC Security Group ID and replace
  subnet_id              = "subnet-4ee95470" # Get one public subnet id from default vpc and replace
  user_data              = file("apache-install.sh") 

# Module Upgrade from v2.x to v5.x 
## In v2.x module, Meta-argument count is used
## In v5.x module, Meta-argument for_each is used
  #instance_count         = 2
  for_each = toset(["one", "two", "three"])

  tags = {
    Name        = "Modules-Demo-${each.key}"
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Step-09: Update Terraform EC2 Instance module outputs to support latest version upgrade changes
- **Terraform Manifests Folder:** terraform-manifests-upgraded
- **File:** c5-outputs.tf
```t
# Output variable definitions

output "ec2_instance_public_ip" {
  description = "Public IP Addressess of EC2 Instances"
  #value = module.ec2_cluster.*.public_ip
  value = [for ec2_cluster in module.ec2_cluster: ec2_cluster.id ]   
}

output "ec2_instance_public_dns" {
  description = "Public DNS for EC2 Instances"
  #value = module.ec2_cluster.*.public_dns
  value = [for ec2_cluster in module.ec2_cluster: ec2_cluster.public_dns ] 
}

output "ec2_instance_private_ip" {
  description = "Private IP Addresses for EC2 Instances"
  #value = module.ec2_cluster.*.private_ip
  value = [for ec2_cluster in module.ec2_cluster: ec2_cluster.private_ip ] 
}
```

## Step-10: Execute Terraform Commands and Verify
- **Terraform Manifests Folder:** terraform-manifests-upgraded
```t
# Terraform Initialize
cd terraform-manifests-upgraded
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-approve

# Verify Application
1. Verify EC2 Instances
2. Verify Application installed (Access using browser with EC2 Instance Public IP)
http://<EC2-Instance-Public-IP>
```


## References
- [Terraform EC2 Instance Module](https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest)