provider "aws" {
  region = "us-east-1"
}

module "kd_vpc" {
  source = "../modules/vpc"
  vpc_cidr = "54.172.60.0/23"
  vpc_tenancy = "default"
  vpc_id="${module.kd_vpc.vpc_id}"
  subnet_cidr="54.172.60.0/27"
}
# module "kd_ec2" {
#   source = "../modules/ec2"
#   count = 1
#   ami_id = "0080e4c5bc078760e"
#   instanceType = "t2.micro"
#   subnet_id = "${module.kd_vpc.subnet_id}"
# }
module "kd_asg" {
  source = "../modules/asg"
  asgname="kd_autoscalinggroup"
  min_scaling_to = 1
  max_scaling_to = 2
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  vpc_zone_identifier = ["${module.kd_vpc.subnet_id}"]
  sec_group_vpc_id = "${module.kd_vpc.vpc_id}"
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
}

