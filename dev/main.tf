provider "aws" {
  region = "us-east-1"
}

module "kd_asg" {
  source = "../modules/asg"
  asgname="kd_autoscalinggroup"
  min_scaling_to = 1
  max_scaling_to = 2
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  config_name = "kd_lc"
  tags_name = "kd_instance1"
  image_id = "ami-0080e4c5bc078760e"
  instanceType = "t2.micro"
}

module "kdcodedeploy" {
  source = "../modules/compute/codedeploy"
  codedepappname = "kdnodeapp"
  iamrolename = "codedepservicerole1"
  depgroupname = "kdnodeappdepgroup"
  deptype = "CodeDeployDefault.OneAtATime"
  s3_bckt_name = "kdcodedepbckt"
  instance_tag = "kd_instance1"
}

