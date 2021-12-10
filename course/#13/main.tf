terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-1"
}

locals {
  ingress_rules = [{
    port        = 443
    description = "Port 443"
    },
    {
      port        = 80
      description = "Port 80"
  }]
}

data "aws_vpc" "main" {
  default = true
}

resource "aws_security_group" "main" {
  name   = "tuts-sg"
  vpc_id = data.aws_vpc.main.id

  dynamic "ingress" {
    for_each = local.ingress_rules

    iterator = foo

    content {
      description = foo.value.description
      from_port   = foo.value.port
      to_port     = foo.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # ingress = {
  #   description = "Port 443"
  #   from_port   = 443
  #   to_port     = 433
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # ingress {
  #   description = "Port 80"
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  tags = {
    Name = "tuts security group"
  }
}
