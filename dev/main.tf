module "kd_vpc" {
  source = "../modules/vpc"
  vpc_cidr = "192.168.0.0/16"
  vpc_tenancy = "default"
  vpc_id="${module.kd_vpc.vpc_id}"
  subnet_cidr="192.168.1.0/24"
}
module "kd_ec2" {
  source = "../modules/ec2"
  count = 1
  ami_id = "${module.kd_ec2.ami_id}"
  instanceType = "t2.micro"
  subnet_id = "${module.kd_vpc.subnet_id}"
}

module "kd_launch_config" {
  source = "../modules/launch_configurations"
  config_name = "mylc"
  image_id = "${module.launch_config.image_id}"
  instanceType = "t2.micro"
  securitygroup_id = "${module.kd_vpc.vpc_id}"
}

module "kd_asg" {
  source = "../modules/asg"
  asgname="kd_autoscalinggroup"
  launch_configuration = "${module.kd_asg.launch_configuration}"
}
