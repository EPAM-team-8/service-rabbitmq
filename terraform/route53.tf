resource "aws_route53_zone" "rabbit_aws" {
  name = "rabbit.com"
vpc {
  vpc_id  = data.aws_vpc.my-vpc.id
  }
}

resource "aws_route53_record" "record" {
  zone_id = aws_route53_zone.rabbit_aws.zone_id
  name = "rabbit.com"
  type = "A"
  ttl  = "300"
  records = [aws_instance.Rabbit.private_ip]
}

resource "aws_route53_zone" "rabbit_pub_aws" {
  name = "rabbit-mq.xyz"
}

resource "aws_route53_record" "record_pub" {
  zone_id = aws_route53_zone.rabbit_pub_aws.zone_id
  name = "rabbit-mq.xyz"
  type = "A"
  ttl  = "300"
  records = [aws_instance.Rabbit.public_ip]
}