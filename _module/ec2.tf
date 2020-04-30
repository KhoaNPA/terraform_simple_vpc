# EC2 in public subnet
resource "aws_instance" "ec2_public" {
  count                       = "${var.instance_number}"
  ami                         = "${var.ami}"
  instance_type               = "${var.ec2_instance_type}"
  key_name                    = "${var.keypair}" # Using existing Keypair on AWS
  vpc_security_group_ids      = ["${aws_security_group.web_sg.id}", "${aws_security_group.icmp_sg.id}"]
  subnet_id                   = "${aws_subnet.public_web_1.id}"
  associate_public_ip_address = "true"
  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.ec2_disk_size}"
  }
  tags = {
    Name        = "${var.env}.${var.vpc_name}.ec2_public"
    Provisioner = "${var.provisioner}"
  }
}

## EBS
resource "aws_ebs_volume" "ec2_public" {
  count             = "${var.instance_number}"
  availability_zone = "${aws_instance.ec2_public[count.index].availability_zone}"
  size              = "${var.ec2_ebs_size}"
  tags              = "${aws_instance.ec2_public[count.index].tags}"
}

resource "aws_volume_attachment" "ec2_public" {
  count       = "${var.instance_number}"
  device_name = "/dev/sdb"
  volume_id   = "${aws_ebs_volume.ec2_public[count.index].id}"
  instance_id = "${aws_instance.ec2_public[count.index].id}"
}

## EIP to assign static IP with Public EC2 
resource "aws_eip" "ec2_public_eip" {
  count    = "${var.instance_number}"
  vpc      = true
  instance = "${aws_instance.ec2_public[count.index].id}"
  tags = {
    Name        = "${var.env}.${var.vpc_name}.web_eip"
    Provisioner = "${var.provisioner}"
  }
}

# EC2 in private subnet
resource "aws_instance" "ec2_private" {
  count                       = "${var.instance_number}"
  ami                         = "${var.ami}"
  instance_type               = "${var.ec2_instance_type}"
  key_name                    = "${var.keypair}" # Using existing Keypair on AWS
  vpc_security_group_ids      = ["${aws_security_group.icmp_sg.id}"]
  subnet_id                   = "${aws_subnet.private_db_1.id}"
  associate_public_ip_address = "false"
  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.ec2_disk_size}"
  }
  tags = {
    Name        = "${var.env}.${var.vpc_name}.ec2_private"
    Provisioner = "${var.provisioner}"
  }
}

## EBS
resource "aws_ebs_volume" "ec2_private" {
  count             = "${var.instance_number}"
  availability_zone = "${aws_instance.ec2_private[count.index].availability_zone}"
  size              = "${var.ec2_ebs_size}"
  tags              = "${aws_instance.ec2_private[count.index].tags}"
}

resource "aws_volume_attachment" "ec2_private" {
  count       = "${var.instance_number}"
  device_name = "/dev/sdb"
  volume_id   = "${aws_ebs_volume.ec2_private[count.index].id}"
  instance_id = "${aws_instance.ec2_private[count.index].id}"
}

