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

# Create a VPC
resource "aws_instance" "example" {
  ami        = "ami-0907c2c44ea451f84"
  instance_type = "t2.micro"
}
