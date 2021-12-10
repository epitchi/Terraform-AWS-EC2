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

data "aws_vpc" "main" {
  default = true
}

locals {
  baz = "hello"
}

variable "testing" {
  type = map
  default = {
    foo = 123
    bar = 555
  }
}

resource "aws_instance" "example" {
  count         = 2
  ami           = "ami-0907c2c44ea451f84"
  instance_type = "t2.micro"

  tags = {
    Name = "Tuts Test ${count.index}"
  }
}

output "foo" {
  # lists out an list/array of instance ids
  #value = aws_instance.web[*].id
  #value = [for instance in aws_instance.web : instance.public_ip]
  #value = [for k, v in var.testing : upper(k)]
  value = [for k, v in var.testing : k if k == "foo"]
}

resource "aws_instance" "tuts" {
  ami           = "ami-0fed77069cd5a6d6c"
  instance_type = "t2.micro"

  tags = {
    Name = "Tuts test ${local.baz}"

    foo = local.baz == "aaa" ? "yes" : "no"

    bar = <<EOT
        testing foo
    EOT

    baz = <<-EOT
      hello from baz, no indentation with the "-"
    EOT

    testing_if = "Hello, %{if var.name != ""}${var.name}%{else}unnamed%{endif}!"

    testing_loop = <<EOT
        %{for ip in aws_instance.example.*.private_ip}
        server ${ip}
        %{endfor}
    EOT
  }

}
