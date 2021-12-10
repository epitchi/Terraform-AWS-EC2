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

resource "aws_instance" "web_east" {
  provider = aws.east
  ami = "ami-061ac2e015473fbe2"
  instance_type = "t2.micro"

  tags = {
    Name = "East Test"
  }

  lifecycle {
    # create_before_destroy = true
    # prevent_destroy = true
    ignore_changes = [
      tags // that's mean "East Test"
    ]
  }
}

resource "aws_instance" "web" {
  for_each = {
    prod = "t2.medium"
    dev  = "t2.micro"
  }
  # count         = 2 # That mean create two instances => can get index  
  ami           = "ami-0d6ba217f554f6137"
  instance_type = each.value

  tags = {
    # Name = "Test ${count.index}" // Output: Generate 2 aws_instance with Name is: "Test 0", "Test 1"
    Name = "Test ${each.key}"
  }
}

# output "foo" {
#   value = aws_instance.web["prod"].public_ip
# }


# output "instance" {
#   value = aws_instance.web[0].public_ip // Return first instance ip 
#   # value = aws_instance.web[*].public_ip // Return a list: instance = {"ip of Instance 1", "ip of Instance 2"}
#   # value = [for instance in aws_instance.web : instance.public_ip] // that's the same as what "28 line" did here

# }
