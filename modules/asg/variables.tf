variable "config_name" {
  default = "mylc"
}

variable "image_id" {}

variable "instanceType" {
  default = "t2.micro"
}

variable "min_scaling_to" {
  default = 1
}


variable "max_scaling_to" {
  default = 2
}

variable "asgname" {
  default = "dev_asg"
}

variable "availability_zones" {
  default = ["us-east-1a"]
}
variable "vpc_zone_identifier" {
  default = []
}

variable "tags_name" {
  default = "kd_insance"
}

variable "region" {
  default = "us-east-1"
}
variable "sec_group_name" {
  default = "kd_sec_group"
}

variable "elbname" {
  default = "kd-elb"
}


variable "elb_securitygroupname" {
  default = "elbsecuritygroup"
}

variable "sec_group_vpc_id" {}



