// Security group for Ping
resource "aws_security_group" "icmp_sg" {
  name        = "${var.env}.${var.vpc_name}.icmp_sg"
  description = "SG allows Ping method (ICMP)"
  vpc_id      = "${aws_vpc.vpc.id}"
  tags = {
    Name        = "${var.env}.${var.vpc_name}.icmp_sg"
    Provisioner = "${var.provisioner}"
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = "${var.sg_public_cidr}"
  }

  egress {
    # egress ALL PROTOCOLS (-1) and ALL PORTS (O-O)
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "${var.sg_public_cidr}"
  }
}


// Security group for web server
resource "aws_security_group" "web_sg" {
  name        = "${var.env}.${var.vpc_name}.web_sg"
  description = "SG allows incomming HTTP/HTTPS & SSH connection"
  vpc_id      = "${aws_vpc.vpc.id}"
  tags = {
    Name        = "${var.env}.${var.vpc_name}.web_sg"
    Provisioner = "${var.provisioner}"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.sg_public_cidr}"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${var.sg_public_cidr}"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.sg_public_cidr}"
  }

  egress {
    # egress ALL PROTOCOLS (-1) and ALL PORTS (O-O)
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "${var.sg_public_cidr}"
  }
}

// Security group for database server
resource "aws_security_group" "db_sg" {
  name   = "${var.env}.${var.vpc_name}.db_sg"
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name        = "${var.env}.${var.vpc_name}.db_sg"
    Provisioner = "${var.provisioner}"
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_public_subnet_1}"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_public_subnet_1}"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_public_subnet_1}"]
  }
}
