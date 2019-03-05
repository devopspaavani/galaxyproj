provider "aws" {
  region = "${var.aws_region}"
}

#-------------VPC-----------

resource "aws_vpc" "namd_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "namd_vpc"
  }
}

#Private Security Group

resource "aws_security_group" "namd_private_sg" {
  name        = "namd_private_sg"
  description = "Used for private instances"
  vpc_id      = "${aws_vpc.namd_vpc.id}"

  # Access from other security groups

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.private_cidr}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "namd_pub_subnet" {
  vpc_id                  = "${aws_vpc.namd_vpc.id}"
  cidr_block              = "${var.public_cidr}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.availability_zones}"

  tags {
    Name = "namd_p"
  }
}

resource "aws_subnet" "namd_pvt_subnet" {
  vpc_id                  = "${aws_vpc.namd_vpc.id}"
  cidr_block              = "${var.private_cidr}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.availability_zones}"

  tags {
    Name = "namd_private"
  }
}

resource "aws_ebs_volume" "this" {
  availability_zone = "${var.availability_zones}"
  size              = 10
  encrypted         = true
  type              = "gp2"
}


resource "aws_instance" "centos_dev" {
  ami                         = "${var.centos_ami}"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.namd_private_sg.id}"]
  key_name                    = "${var.key_name}"
  associate_public_ip_address = true

  #private_ip = "${var.private_ip}"
  #ebs_optimized = true
  #disable_api_termination = true
  subnet_id = "${aws_subnet.namd_pub_subnet.id}"
}

resource "aws_volume_attachment" "this_ec2" {
  device_name  = "/dev/sdh"
  volume_id    = "${aws_ebs_volume.this.id}"
  instance_id  = "${aws_instance.centos_dev.id}"
  skip_destroy = true
}
