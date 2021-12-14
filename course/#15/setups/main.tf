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

provider "aws" {
  alias = "east"
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

module "wills_webserver" {
  source         = "../modules/webserver"
  vpc_id         = aws_vpc.main.id
  cidr_block     = "10.0.0.0/16"
  webserver_name = "Will"
  ami            = "ami-07315f74f3fa6a5a3"
  instance_type  = "t2.micro"
}

module "wills_webserver_east" {
  source = "../modules/webserver"
  providers = {
    aws = aws.east
   }
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/16"
  webserver_name = "Will-east"
  ami            = "ami-07315f74f3fa6a5a3"
  instance_type  = "t2.micro"
}