resource "aws_autoscaling_group" "kd_asg" {
  name                 = "${var.asgname}"
  launch_configuration = "${var.configuration}"
}

output "launch_configuration" {
  value = "${kd_asg.launch_configuration.launch_configuration}"
}
