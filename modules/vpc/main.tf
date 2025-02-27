# Create the vpc
resource "aws_vpc" "this" {
  cidr_block                       = var.cidr
  enable_dns_hostnames             = true
  enable_dns_support               = true
  assign_generated_ipv6_cidr_block = true

  tags = {
    Name = var.vpc_name
  }

}

data "aws_availability_zones" "available_zones" {
  state = "available"
}

# Create Public Subnets
resource "aws_subnet" "public_subnets" {
  count                                          = 1
  vpc_id                                         = aws_vpc.this.id
  ipv6_native                                    = true
  availability_zone                              = element(data.aws_availability_zones.available_zones.names, count.index)
  assign_ipv6_address_on_creation                = true
  enable_resource_name_dns_aaaa_record_on_launch = true
  ipv6_cidr_block                                = cidrsubnet(aws_vpc.this.ipv6_cidr_block, 8, count.index)
  map_public_ip_on_launch                        = false # No public IPv4s for public subnets
  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index + 1}"
  }
}


# create internet gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}


# Create Public Route Table for public subnets(IPv6)
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.this.id
  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.this.id
  }
  tags = {
    Name = "${var.vpc_name}-public-route-table"
  }
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public_rt_assoc" {
  count          = 1
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}
