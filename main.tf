provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_ebs_volume" "this" {
  availability_zone = "${var.availability_zones}"
  size              = 10
  encrypted = true
  type = "gp2"
}

resource "aws_instance" "centos_dev" {
  ami             = "${var.centos_ami}"
  instance_type   = "t2.micro"
  vpc_security_group_ids = ["${var.aws_security_group_id}"]
  key_name         = "${var.key_name}"
  associate_public_ip_address = false
  #private_ip = "${var.private_ip}"
  #ebs_optimized = true
  #disable_api_termination = true
  subnet_id = "subnet-0095f47a"
}

resource "aws_volume_attachment" "this_ec2" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.this.id}"
  instance_id = "${aws_instance.centos_dev.id}"
  skip_destroy = true
}