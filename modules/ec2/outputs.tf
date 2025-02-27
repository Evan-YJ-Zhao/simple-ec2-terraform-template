output "security_group_id" {
  value = aws_security_group.sg.id
}

output "ec2_id" {
  value = aws_instance.windows_ec2.id
}

output "ec2_public_dns" {
  value = aws_instance.windows_ec2.public_dns
}