# VPC
resource "aws_vpc" "ec2VPC" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "ec2VPC"
  }
}

# VPC Internet Gateway
resource "aws_internet_gateway" "ec2IG" {
  vpc_id = aws_vpc.ec2VPC.id
  tags = {
    Name = "ec2IG"
  }
}

# Public subnet 1
resource "aws_subnet" "ec2_public_sn_01" {
  vpc_id            = aws_vpc.ec2VPC.id
  cidr_block        = var.subnet1_cidr_block
  availability_zone = var.sunet1_availability_zone
  tags = {
    Name = "ec2_public_sn_01"
  }
}

# Routing table for public subnet 1
resource "aws_route_table" "ec2_public_sn_rt_01" {
  vpc_id = aws_vpc.ec2VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ec2IG.id
  }
  tags = {
    Name = "ec2_public_sn_rt_01"
  }
}
# Associate the routing table to public subnet 1
resource "aws_route_table_association" "ec2_public_sn_rt_01_assn" {
  subnet_id      = aws_subnet.ec2_public_sn_01.id
  route_table_id = aws_route_table.ec2_public_sn_rt_01.id
}

# Public subnet 2
resource "aws_subnet" "ec2_public_sn_02" {
  vpc_id            = aws_vpc.ec2VPC.id
  cidr_block        = var.subnet2_cidr_block
  availability_zone = var.sunet2_availability_zone
  tags = {
    Name = "ec2_public_sn_02"
  }
}
# Routing table for public subnet 2
resource "aws_route_table" "ec2_public_sn_rt_02" {
  vpc_id = aws_vpc.ec2VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ec2IG.id
  }
  tags = {
    Name = "ec2_public_sn_rt_02"
  }
}
# Associate the routing table to public subnet 2
resource "aws_route_table_association" "ec2_public_sn_rt_02_assn" {
  subnet_id      = aws_subnet.ec2_public_sn_02.id
  route_table_id = aws_route_table.ec2_public_sn_rt_02.id
}

# Public subnet 3
resource "aws_subnet" "ec2_public_sn_03" {
  vpc_id            = aws_vpc.ec2VPC.id
  cidr_block        = var.subnet3_cidr_block
  availability_zone = var.sunet3_availability_zone
  tags = {
    Name = "ec2_public_sn_03"
  }
}
# Routing table for public subnet 3
resource "aws_route_table" "ec2_public_sn_rt_03" {
  vpc_id = aws_vpc.ec2VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ec2IG.id
  }
  tags = {
    Name = "ec2_public_sn_rt_03"
  }
}
# Associate the routing table to public subnet 3
resource "aws_route_table_association" "ec2_public_sn_rt_03_assn" {
  subnet_id      = aws_subnet.ec2_public_sn_03.id
  route_table_id = aws_route_table.ec2_public_sn_rt_03.id
}

#  Instance Security group
resource "aws_security_group" "ec2_public_sg" {
  name   = "ec2_public_sg"
  vpc_id = aws_vpc.ec2VPC.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "tcp"
    cidr_blocks = [
    var.subnet1_cidr_block, var.subnet2_cidr_block, var.subnet3_cidr_block]
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_public_sg"
  }
}

resource "aws_security_group" "ec2_VPN" {
  name   = "ec2_VPN"
  vpc_id = aws_vpc.ec2VPC.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  ingress {
    from_port = 943
    to_port   = 943
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  ingress {
    from_port = 1194
    to_port   = 1194
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "tcp"
    cidr_blocks = [
      var.subnet1_cidr_block, var.subnet2_cidr_block, var.subnet3_cidr_block
    ]
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "ec2_VPN"
  }
}

