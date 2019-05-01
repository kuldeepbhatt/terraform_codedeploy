
data "template_file" "user_data" {

  template = "${file("../modules/asg/userdata.sh")}"
  vars = {
    region = "${var.region}"
  }
}

## Security Group for ELB
resource "aws_security_group" "kd_sec_group" {
  name = "${var.sec_group_name}"
  vpc_id      = "${var.sec_group_vpc_id}"
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "kd_sec_group"
  }
}
## Creating Launch Configuration
resource "aws_launch_configuration" "kd_launch_config" {
  name          = "${var.config_name}"
  image_id      = "${var.image_id}"
  instance_type = "${var.instanceType}"
  security_groups = ["${aws_security_group.kd_sec_group.id}"]
  user_data = "${data.template_file.user_data.rendered}"
  
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
  vpc_zone_identifier = ["${var.vpc_zone_identifier}"]
  
  load_balancers = ["${aws_elb.kd-elb.name}"]
  tag {
   key                 = "Name"
   value               = "${var.tags_name}"
   propagate_at_launch = "true"
  }
  lifecycle {
    create_before_destroy = true
  }
}
## Security Group for ELB
resource "aws_security_group" "elb_sec_group" {
  name = "${var.elb_securitygroupname}"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
### Creating ELB
resource "aws_elb" "kd-elb" {
  name = "${var.elbname}"
  security_groups = ["${aws_security_group.elb_sec_group.id}"]
  availability_zones = "${var.availability_zones}"
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:8080/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "8080"
    instance_protocol = "http"
  }
}