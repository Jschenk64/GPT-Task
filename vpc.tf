# VPC
resource "aws_vpc" "grippo_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "Grippo-vpc"
    Environment = "Development"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "grippo_igw" {
  vpc_id = aws_vpc.grippo_vpc.id

  tags = {
    Name = "Grippo-IGW"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "grippo_eip" {
  domain = "vpc"
}

# NAT Gateway
resource "aws_nat_gateway" "grippo_nat" {
  allocation_id = aws_eip.grippo_eip.id
  subnet_id     = aws_subnet.grippo_public_subnet_1.id

  tags = {
    Name = "Grippo-NAT"
  }
}

# Route Tables
resource "aws_route_table" "grippo_public_route" {
  vpc_id = aws_vpc.grippo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.grippo_igw.id
  }

  tags = {
    Name = "Public-Route-Grippo"
  }
}

resource "aws_route_table" "grippo_private_route" {
  vpc_id = aws_vpc.grippo_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.grippo_nat.id
  }

  tags = {
    Name = "Private-Route-Grippo"
  }
}

# Route Table Associations
resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.grippo_public_subnet_1.id
  route_table_id = aws_route_table.grippo_public_route.id
}

resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.grippo_public_subnet_2.id
  route_table_id = aws_route_table.grippo_public_route.id
}

resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = aws_subnet.grippo_private_subnet_1.id
  route_table_id = aws_route_table.grippo_private_route.id
}

resource "aws_route_table_association" "private_assoc_2" {
  subnet_id      = aws_subnet.grippo_private_subnet_2.id
  route_table_id = aws_route_table.grippo_private_route.id
}

# Security Groups
resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.grippo_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with your trusted IP
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public-SG-Grippo"
  }
}

resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.grippo_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.150.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Private-SG-Grippo"
  }
}