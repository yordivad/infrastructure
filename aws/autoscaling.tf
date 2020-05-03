
resource "aws_autoscaling_group" "master_scaling" {
  name = "demo_scaling"
  max_size = 2
  min_size = 1
  launch_configuration = aws_launch_configuration.master.name
  vpc_zone_identifier = [aws_subnet.private_subnet.id]
  load_balancers = [aws_elb.balancer.id]
  health_check_type = "ELB"

  lifecycle {
    create_before_destroy = true
  }
}
