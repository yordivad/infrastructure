# define a vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

# define Internet Gateway
resource "aws_internet_gateway" "gateway" {
    vpc_id = aws_vpc.vpc.id
    tags = {
      Name = "gateway"
    }
}

# define a eip for nat gateway
resource "aws_eip" "nat_ip" {
  vpc = true
  tags = {
    Name = "nat_public_ip"
  }
}

# define nat gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id = aws_subnet.public_subnet.id
  depends_on = [aws_internet_gateway.gateway]
}

# public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.vpc_public_cidr
  map_public_ip_on_launch = true
  availability_zone = lookup(var.availability_zone, var.aws_region )
  tags = {
    Name = "public_subnet"
  }
}

# private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.vpc_private_cidr
  availability_zone = "us-east-1b"
  tags = {
    Name = "private_subnet"
  }
}

# Routing table for public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }
  tags = {
    Name = "public_route_table"
  }
}

# Routing table for private subnet
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "private_route_table"
  }
}


# Assing the route table to public subnet.
resource "aws_route_table_association" "public_subnet_table" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.public_subnet.id
}

# Assing the route table to private subnet.
resource "aws_route_table_association" "private_subnet_table" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id = aws_subnet.private_subnet.id
}

# Assing the the route table as main table.
resource "aws_main_route_table_association" "main_route" {
  route_table_id = aws_route_table.private_route_table.id
  vpc_id = aws_vpc.vpc.id
}

# public ipsec
resource "aws_security_group" "public_ipsec" {
  name = "public_ipsec"
  description = "public subnet ip security"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public_ipsec"
  }

}

# private ipsec
resource "aws_security_group" "private_ipsec" {
  name = "private_ipsec"
  description = "private subnet ipsec"
  vpc_id = aws_vpc.vpc.id

  # allow mysql port within VPC.
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [aws_subnet.public_subnet.cidr_block]
  }

  # allow http port connections.
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [aws_subnet.public_subnet.cidr_block]
  }

  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private_ipsec"
  }

}
