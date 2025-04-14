#! /bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo service httpd start  
sudo systemctl enable httpd
echo "<h1>Welcome to SanketNalage World ! AWS Infra created using Terraform in eu-north-1 Region</h1>" > /var/www/html/index.html