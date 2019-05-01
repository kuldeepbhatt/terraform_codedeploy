
data "template_file" "user_data" {

  template = "${file("../modules/asg/userdata.sh")}"
  vars = {
    region = "${var.region}"
  }
}
resource "aws_iam_role" "s3_access_role" {
  name = "${var.s3_access_role_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      tag-key = "tag-value"
  }
}

resource "aws_iam_role_policy" "s3_access_policy" {
  name = "${var.s3_access_policy_name}"
  role = "${aws_iam_role.s3_access_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
resource "aws_iam_instance_profile" "s3_access_profile" {
  name = "${var.s3_access_profile_name}"
  role = "${aws_iam_role.s3_access_role.name}"
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
  iam_instance_profile = "${aws_iam_instance_profile.s3_access_profile.name}"
  
  lifecycle {
    create_before_destroy = true
  }
}
# resource "aws_elb" "kd-elb" {
#   name = "${var.elbname}"
#   security_groups = ["${aws_security_group.kd_sec_group.id}"]
#   availability_zones = "${var.availability_zones}"
#   health_check {
#     healthy_threshold = 2
#     unhealthy_threshold = 2
#     timeout = 3
#     interval = 30
#     target = "HTTP:8080/"
#   }
#   listener {
#     lb_port = 80
#     lb_protocol = "http"
#     instance_port = "8080"
#     instance_protocol = "http"
#   }
# }

resource "aws_autoscaling_group" "kd_asg" {
  name                 = "${var.asgname}"
  launch_configuration = "${aws_launch_configuration.kd_launch_config.name}"
  min_size             = "${var.min_scaling_to}"
  max_size             = "${var.max_scaling_to}"
  availability_zones = "${var.availability_zones}"
  vpc_zone_identifier = ["${var.vpc_zone_identifier}"]
  
  # load_balancers = ["${aws_elb.kd-elb.name}"]
  tag {
   key                 = "Name"
   value               = "${var.tags_name}"
   propagate_at_launch = "true"
  }
  lifecycle {
    create_before_destroy = true
  }
}
