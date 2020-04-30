# Variable for all modules within this folder
# Define variables without 'default' values for creating Terraform module.

# VPC
variable "env" {
  description = "Environment's name"
}

variable "provisioner" {
  description = "Provisioner"
}

#VPC
variable "vpc_name" {
  description = "VPC's name"
}

variable "region" {
  description = "VPC's Region"
}

variable "vpc_cidr" {
  description = "VPC's Classless Inter-Domain Routing (CIDR)"
}

variable "vpc_public_subnet_1" {
  description = "Public subnet for EC2"
}

variable "vpc_private_subnet_1" {
  description = "Private subnet for DB"
}

variable "sg_public_cidr" {
  description = "Public CIDR for SG allowing from internet"
}

# EC2 
variable "instance_number" {
  description = "Number of EC2 instance"
}

variable "ami" {
  description = "AMI for EC2. Amazon Linux 2 AMI (HVM), SSD Volume Type - ami-0cbc6aae997c6538a (64-bit x86) / ami-09172771b47695ce2 (64-bit Arm) at AP-SOUTHEAST-1."
}

variable "keypair" {
  description = "EC2's keypair"
}

variable "ec2_instance_type" {
  description = "EC2's instance type"
}

variable "ec2_disk_size" {
  description = "EC2's ephemeral disk size (GB)"
}

variable "ec2_ebs_size" {
  description = "EC's EBS disk size (GB)"
}
