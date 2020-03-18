#Local user to access the AMI
locals {
  ec2_user = "gpriya"
}

data "aws_ami" "ubuntu" {
  owners = ["amazon"]
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "auth" {
  public_key = file(var.public_key_path)
}

resource "aws_instance" "Web_Instance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  tags = var.tags

  vpc_security_group_ids = ["aws_security_group.default.id"]
  subnet_id = "aws_subnet.default.id"
  # To check the connectivity to the Web instance server after it is provisioned
  provisioner "remote-exec" {
    inline = ["Web Instance connected successfully"]

    connection {
      user = "local.ec2_user"
    }
  }
}