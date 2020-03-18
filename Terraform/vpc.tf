#Creating VPC to launch the EC2 instance
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
  tags = var.tags
}

# To create an internet gateway for the subnets to access outside the VPC
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags = var.tags
}

# Create route table to grant VPC internet access
resource "aws_route" "internet_access" {
  route_table_id = "aws_vpc.default.main_route_table_id"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "aws_internet_gateway.default.id"
}

# To create subnets to launch EC2 instances
resource "aws_subnet" "default" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.default.id
  map_public_ip_on_launch = true
  tags = var.tags
}

# To create security group for our to access EC2 instances using SSH & HTTP
resource "aws_security_group" "default" {
  name = "terraform_security"
  description = "Used for terraform Ansible Infra Project"
  vpc_id = aws_vpc.default.id
  tags = var.tags

  #To allow SSH access
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  #To allow HTTP access
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Outbound Rules
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

