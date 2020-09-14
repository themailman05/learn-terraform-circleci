terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "template" {
}

resource "aws_vpc" "tf-demo" {
   cidr_block = "10.111.0.0/16"
}

resource "aws_subnet" "tf-demo-sub" {
  vpc_id     = aws_vpc.tf-demo.id
  cidr_block = "10.111.1.0/24"

  tags = {
    Name = "subnet"
  }
}

resource "random_uuid" "randomid" {}



data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.tf-demo-sub.id
  tags = {
    Name = "HelloWorld-One"
  }
}

