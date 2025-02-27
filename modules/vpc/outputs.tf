output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_id" {
  description = "public subnet ID"
  value       = aws_subnet.public_subnets[0].id
}