terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}


resource "aws_instance" "example" {
  ami           = "ami-0907c2c44ea451f84"
  instance_type = var.my_instance_type
    tags = var.instance_tags
}
