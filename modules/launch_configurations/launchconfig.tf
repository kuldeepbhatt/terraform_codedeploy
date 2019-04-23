resource "aws_launch_configuration" "kd_launch_config" {
  name          = "${var.config_name}"
  image_id      = "${var.image_id}"
  instance_type = "${var.instanceType}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_default_security_group" "kd_security_group" {
  vpc_id = "${var.securitygroup_id}"

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }
}

output "vpc_id" {
  value = "${aws_default_security_group.security_group.id}"
}

output "image_id" {
  value = "${aws_launch_configuration.launch_config.id}"
}