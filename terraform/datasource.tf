data "aws_vpc" "my-vpc"{
    filter {
    name = "tag:Name"
    values = ["my-vpc"]
  }
}

data "aws_subnet" "public_subnet" {
  vpc_id = data.aws_vpc.my-vpc.id
  filter {
    name = "tag:Name"
    values = ["public"]
  }
}

data "aws_route53_zone" "rabbit-zone" {
name         = "epam.one."
}

data "aws_subnet" "private_subnet" {
  vpc_id = data.aws_vpc.my-vpc.id
  filter {
    name = "tag:Name"
    values = ["private"]
  }
}

data "aws_security_group" "sg" {
    vpc_id =  data.aws_vpc.my-vpc.id
    name = "all"
}

data "aws_availability_zones" "available" {}

output "vpc" {
    value = data.aws_vpc.my-vpc.id
}
output "subnet" {
    value = data.aws_subnet.public_subnet.id
}

output "sg" {
    value = data.aws_security_group.sg.id
}