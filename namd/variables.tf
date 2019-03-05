variable "aws_region" {
  default = "us-east-2"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "centos_ami" {
  default = "ami-0f2b4fc905b0bd1f1"
}

variable "aws_security_group_id" {
  default = "sg-000c3faa84fc369c9"
}

variable "private_ip" {
  default = "172.31.16.12"
}

variable "private_cidr" {
  default = "10.0.3.0/24"
}

variable "public_cidr" {
  default = "10.0.1.0/24"
}

variable "availability_zones" {
  default = "us-east-2b"
}

variable "key_name" {
    default = "aws-popurivamsi"
}
variable "public_key_path" {
    default	= "namdkey.pub"
}
