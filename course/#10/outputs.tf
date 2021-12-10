output "vpc" {
  value = aws_vpc.main
}

output "instance_ip" {
  value = aws_instance.web.public_ip
}

output "foobar" {
  value = "Tuts"
}