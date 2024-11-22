provider "aws" {
  region = var.region
}

resource "aws_instance" "web_instance_1" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.grippo_public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  associate_public_ip_address = true # Disable public IP
  key_name               = var.key_name

  tags = {
    Name = "Grippo-Web-Instance-1"
  }
}

resource "aws_instance" "web_instance_2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.grippo_public_subnet_2.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  associate_public_ip_address = true # Disable public IP
  key_name               = var.key_name

  tags = {
    Name = "Grippo-Web-Instance-2"
  }
}

resource "aws_instance" "rds_instance_1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.grippo_private_subnet_1.id
  key_name      = var.key_name

  tags = {
    Name = "Grippo-rds-instance-1"
  }
}


resource "aws_instance" "rds_instance_2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.grippo_private_subnet_2.id
  key_name      = var.key_name

  tags = {
    Name = "Grippo-rds-instance-2"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

# Public Subnets
resource "aws_subnet" "grippo_public_subnet_1" {
  vpc_id            = aws_vpc.grippo_vpc.id
  cidr_block        = var.public_subnet_cidrs[0]
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "Grippo-Public-Subnet-1"
  }
}

resource "aws_subnet" "grippo_public_subnet_2" {
  vpc_id            = aws_vpc.grippo_vpc.id
  cidr_block        = var.public_subnet_cidrs[1]
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "Grippo-Public-Subnet-2"
  }
}

# Private Subnets
resource "aws_subnet" "grippo_private_subnet_1" {
  vpc_id            = aws_vpc.grippo_vpc.id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "Grippo-Private-Subnet-1"
  }
}

resource "aws_subnet" "grippo_private_subnet_2" {
  vpc_id            = aws_vpc.grippo_vpc.id
  cidr_block        = var.private_subnet_cidrs[1]
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "Grippo-Private-Subnet-2"
  }
}
