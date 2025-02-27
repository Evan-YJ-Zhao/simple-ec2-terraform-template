variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "my_ipv6" {
  description = "my ipv6 for ssh connection"
  type        = string
}

variable "ami_id" {
  description = "ami id"
  type        = string
  default     = "ami-0d31ac04c1d894d66"
}

variable "subnet_id" {
  description = "subnet id"
  type        = string
}