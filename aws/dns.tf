
data "aws_route53_zone" "mlambda" {
  name = "mlambda.net"
}

resource "aws_route53_record" "sample" {
  name = acme_certificate.certificate.certificate_domain
  type = "A"
  zone_id = data.aws_route53_zone.mlambda.zone_id
  alias {
    evaluate_target_health = true
    name = aws_elb.balancer.dns_name
    zone_id = aws_elb.balancer.zone_id
  }
}

