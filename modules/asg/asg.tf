
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

## Creating Launch Configuration
resource "aws_launch_configuration" "kd_launch_config" {
  name          = "${var.config_name}"
  image_id      = "${var.image_id}"
  instance_type = "${var.instanceType}"
  user_data = "${data.template_file.user_data.rendered}"
  iam_instance_profile = "${aws_iam_instance_profile.s3_access_profile.name}"
  
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
  tag {
   key                 = "Name"
   value               = "${var.tags_name}"
   propagate_at_launch = "true"
  }
  lifecycle {
    create_before_destroy = true
  }
}
