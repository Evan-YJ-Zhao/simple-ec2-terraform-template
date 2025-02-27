terraform {

  required_version = "~> 1.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "vpc" {
  source     = "./modules/vpc"
  vpc_name   = local.vpc_name
  aws_region = local.aws_region
  cidr       = local.vpc_cidr
}

module "ec2" {
  source    = "./modules/ec2"
  vpc_id    = module.vpc.vpc_id
  my_ipv6   = local.my_ipv6
  subnet_id = module.vpc.public_subnet_id
}