resource "aws_codedeploy_app" "kdcodedeploy" {
  name = "${var.codedepappname}"
}

resource "aws_iam_role" "codedeploy_service" {
  name = "${var.iamrolename}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
    "Sid": "",
    "Effect": "Allow",
    "Principal": {
    "Service": [
        "codedeploy.us-east-1.amazonaws.com",
        "codedeploy.us-west-2.amazonaws.com"
    ]
    },
    "Action": "sts:AssumeRole"
    }
 ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = "${aws_iam_role.codedeploy_service.name}"
}

# create a deployment group
resource "aws_codedeploy_deployment_group" "kdcodedepgroup" {
  app_name              = "${aws_codedeploy_app.kdcodedeploy.name}"
  deployment_group_name = "${var.depgroupname}"
  service_role_arn      = "${aws_iam_role.codedeploy_service.arn}"

  deployment_config_name = "${var.deptype}" # AWS defined deployment config

  ec2_tag_filter = {
    key   = "Name"
    type  = "KEY_AND_VALUE"
    value = "CodeDeployDemo"
  }

  # trigger a rollback on deployment failure event
  auto_rollback_configuration {
    enabled = true
    events = [
      "DEPLOYMENT_FAILURE",
    ]
  }
}


resource "aws_s3_bucket" "kd_s3_bucket" {
  bucket = "${var.s3_tf_bckt_name}"
  tags = {
    Name        = "${var.s3_bckt_name}"
    Environment = "${var.env}"
  }
  versioning {
    enabled = true
}
}