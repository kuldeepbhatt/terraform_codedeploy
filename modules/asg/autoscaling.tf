resource "aws_autoscaling_group" "kd_asg" {
  name                 = "${var.asgname}"
  launch_configuration = "${var.configuration}"
}

output "configuration" {
  value = "${aws_autoscaling_group.kd_asg.launch_configuration}"
}
