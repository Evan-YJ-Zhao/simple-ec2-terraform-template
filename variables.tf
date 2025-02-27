variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC cidr"
  type        = string
}


variable "my_ipv6" {
  description = "my ipv6 for ssh connection"
  type        = string
}