
# Output for VPC Network
output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "subnets" {
  value = "[${aws_subnet.private_db_1.id}, ${aws_subnet.public_web_1.id}]"
}

output "public_routable" {
  value = "${aws_route_table.public_rtb}"
}


