
resource "aws_security_group" "elb_ipsec" {
  vpc_id = aws_vpc.vpc.id
  name = "elb_ipsec"
  description = "load balancer ipsec"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elb_ipsec"
  }

}

resource "aws_elb" "balancer" {
  name = "balancer"
  security_groups = [aws_security_group.elb_ipsec.id]
  subnets = [aws_subnet.public_subnet.id, aws_subnet.private_subnet.id]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 443
    lb_protocol = "https"
    ssl_certificate_id = aws_iam_server_certificate.elb_cert.arn
  }

  tags = {
    Name = "load_balancer"
  }
}
