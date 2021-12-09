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
  setup_name = "tuts"
  foobar     = upper("will")
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
#   bar        = local.foobar

  tags = {
    Name = "${local.setup_name}-vpc"
    foo  = local.setup_name
  }
}

resource "aws_subnet" "web" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/16"
#   bar        = local.foobar

  tags = {
    Name = "${local.setup_name}-subnet"
  }
}

# Create a VPC
resource "aws_instance" "example" {
  # ami           = "ami-0907c2c44ea451f84"
  ami           = "ami-0d6ba217f554f6137"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.web.id


  tags = {
    Name = "${local.setup_name}-example"
    foo  = "bar"
  }
}
