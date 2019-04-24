resource "aws_launch_configuration" "kd_launch_config" {
  name          = "${var.config_name}"
  image_id      = "${var.image_id}"
  instance_type = "${var.instanceType}"
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "kd_asg" {
  name                 = "${var.asgname}"
  launch_configuration = "${aws_launch_configuration.kd_launch_config.name}"
  min_size             = "${var.min_scaling_to}"
  max_size             = "${var.max_scaling_to}"
  availability_zones = "${var.availability_zones}"

  lifecycle {
    create_before_destroy = true
  }
}