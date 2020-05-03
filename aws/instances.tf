
resource "aws_launch_configuration" "master" {
  name = "master"
  key_name = var.ssh_key_name
  enable_monitoring = false
  image_id = "ami-039a49e70ea773ffc"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.private_ipsec.id]
  associate_public_ip_address = false
  user_data = file("${path.module}/scripts/user_data.sh")
  placement_tenancy = "default"

  root_block_device {
    volume_size = "30"
    volume_type = "gp2"
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

}
