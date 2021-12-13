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

resource "aws_instance" "web" {
  ami           = "ami-0fed77069cd5a6d6c"
  instance_type = "t2.micro"

  tags = {
    Name = "Tuts test"
  }

  # provisioner "local-exec" {
  #   // self keyword does is allow you to access any attributes from the AWS Instance
  #   command = "echo ${self.public_ip} > public-ip.txt"
  # }

  # connection {
  #   type = "ssh"
  #   host = self.public_ip
  #   user = "ubuntu"
  #   private_key = file("/library/epitchi-devops/terraform/course/key_name.pem")
  # }

  provisioner "remote-exec" {
    # on_failure = "continue"
    # when = "destroy"
    # inline = [
    #   "touch path"
    # ]
  }

  # provisioner "file" {
  #   content     = "foobar"
  #   destination = "/library/epitchi-devops/terraform/course"
  # }
}
