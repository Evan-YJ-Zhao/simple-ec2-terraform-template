# Create a Security Group that Only Allows SSH from My IPv6
resource "aws_security_group" "sg" {
  vpc_id      = var.vpc_id
  name        = "SSH-Only SG"
  description = "SSH-Only from my IP"

  # not the best practice, but simple enough for testing
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    ipv6_cidr_blocks = [var.my_ipv6]
  }

    # Allow RDP (port 3389) for remote desktop access
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    ipv6_cidr_blocks = [var.my_ipv6]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "SSHOnlySecurityGroup"
  }
}


resource "tls_private_key" "ec2_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "ssh-simple-ec2-key-pair"
  public_key = tls_private_key.ec2_private_key.public_key_openssh
}

resource "local_file" "private_key" {
  filename = "${path.root}/simple-ec2-key.pem"
  content  = tls_private_key.ec2_private_key.private_key_pem
}

# FOR NOW, will add support for LINUX machines
resource "aws_instance" "windows_ec2" {
  ami                    = var.ami_id
  instance_type          = "t3.medium"
  key_name               = aws_key_pair.ec2_key_pair.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = "WindowsEC2"
  }
}

