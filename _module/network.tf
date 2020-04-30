# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags = {
    Name        = "${var.env}.${var.vpc_name}"
    Provisioner = "${var.provisioner}"
  }
}

# Provide internet to VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name        = "${var.env}.${var.vpc_name}.igw"
    Provisioner = "${var.provisioner}"
  }
}

# Subnet for EC2 (public subnet)
resource "aws_subnet" "public_web_1" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.vpc_public_subnet_1}"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.env}.${var.vpc_name}.web.a1.public"
    Provisioner = "${var.provisioner}"
  }
}

# Subnet for DB (private subnet)
resource "aws_subnet" "private_db_1" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.vpc_private_subnet_1}"
  availability_zone = "${var.region}a"
  tags = {
    Name        = "${var.env}.${var.vpc_name}.db.b1.private"
    Provisioner = "${var.provisioner}"
  }
}

# Assign Route table to associate all public subnets
resource "aws_route_table" "public_rtb" {
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags = {
    Name        = "${var.env}.${var.vpc_name}.public_rtb"
    Provisioner = "${var.provisioner}"
  }
}

resource "aws_route_table_association" "public_web_1" {
  route_table_id = "${aws_route_table.public_rtb.id}"
  subnet_id      = "${aws_subnet.public_web_1.id}"
}
