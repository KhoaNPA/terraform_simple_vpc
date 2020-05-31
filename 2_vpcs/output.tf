# VPC 1
output "tf-vpc-1" {
  value = "${module.tf-vpc-1.vpc_id}"
}

output "tf-vpc-1_subnets" {
  value = "${module.tf-vpc-1.subnets}"
}

output "tf-vpc-1_public-routable" {
  value = "${module.tf-vpc-1.public_routable}"
}
