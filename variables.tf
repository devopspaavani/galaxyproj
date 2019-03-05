variable "aws_region" {
  default = "us-east-2"
}

variable "aws_vpc" {
  default = "vpc-a91f1cc1"
}

variable "centos_ami" {
  default = "ami-0f2b4fc905b0bd1f1"
}

variable "aws_security_group_id" {
  default = "sg-000c3faa84fc369c9"
}

variable "key_name" {
  default = "aws-popurivamsi"
}

variable "private_ip" {
    default = "172.31.16.12"
}

variable "availability_zones" {
  default     = "us-east-2b"
}
