output "vpc_id" {
  description = "VPC id"
  value       = module.vpc.vpc_id
}

output "subnet_id" {
  description = "subnet id"
  value       = module.vpc.public_subnet_id
}

output "ec2_id" {
  value = module.ec2.ec2_id
}

output "ec2_public_dns" {
  value = module.ec2.ec2_public_dns
}