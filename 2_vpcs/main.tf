provider "aws" {
  version = "~> 2.0"
  region  = "ap-southeast-1"
}

# Terraform Backend (Initializing step, NOT allows 'var' or 'local' here)
terraform {
  required_version = ">= 0.12.0"
}

module "tf-vpc-1" {
  source = "../_module"

  env         = "Transit-Gateway-Example"
  provisioner = "Terraform"
  # VPC
  vpc_name             = "tf-vpc-1"
  region               = "ap-southeast-1"
  vpc_cidr             = "10.101.0.0/16"
  vpc_public_subnet_1  = "10.101.1.0/24"
  vpc_private_subnet_1 = "10.101.2.0/24"
  sg_public_cidr       = ["0.0.0.0/0"]

  # EC2
  instance_number   = 1
  ami               = "ami-0cbc6aae997c6538a"
  ec2_instance_type = "t2.micro"
  keypair           = "my-aws-existing-keypair" # Change to your Keypair on AWS
  ec2_disk_size     = 8  #GB
  ec2_ebs_size      = 10 #GB
}

module "tf-vpc-2" {
  source = "../_module"

  env         = "Transit-Gateway-Example"
  provisioner = "Terraform"
  # VPC
  vpc_name             = "tf-vpc-1"
  region               = "ap-southeast-1"
  vpc_cidr             = "10.102.0.0/16"
  vpc_public_subnet_1  = "10.102.1.0/24"
  vpc_private_subnet_1 = "10.102.2.0/24"
  sg_public_cidr       = ["0.0.0.0/0"]

  # EC2
  instance_number   = 1
  ami               = "ami-0cbc6aae997c6538a"
  ec2_instance_type = "t2.micro"
  keypair           = "my-aws-existing-keypair" # Change to your Keypair on AWS
  ec2_disk_size     = 8  #GB
  ec2_ebs_size      = 10 #GB
}
