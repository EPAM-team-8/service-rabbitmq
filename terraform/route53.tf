resource "aws_route53_record" "record" {
  zone_id = data.aws_route53_zone.rabbit-zone.zone_id
  name = "rabbit.epam.one"
  type = "A"
  ttl  = "300"
  records = [aws_instance.Rabbit.public_ip]
}