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


/*
  One of method grab data belike fetch API in Terraform to using data from "tuts" (aws_vpc)
*/
# data "aws_vpc" "tuts"{
#   default = true 
# }

# output "foo" {
#   value = data.aws_vpc.tuts.id
# }


# // Get data by Name filter
# data "aws_vpc" "tuts" {
#   filter {
#     name  = "tag:Name"
#     value = ["Tuts"]
#   }
# }

# output "foo" {
#   value = data.aws_vpc.tuts
# }

data "aws_ami" "main_ami" {
  owners = ["self "] # The argument "owner" is required!
  most_recent = true
}

resource "aws_subnet" "web" {
  vpc_id     = data.aws_vpc.tuts
  cidr_block = "10.0.0.0/16"
}

# Create a VPC
resource "aws_instance" "web" {
  # ami           = "ami-0907c2c44ea451f84"
  # ami           = "ami-0d6ba217f554f6137"
  ami           = data.aws_ami.main_ami.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.web.id
}
