variable "config_name" {
  default = "mylc"
}

variable "image_id" {}

variable "instanceType" { default = "t2.micro"}

variable "min_scaling_to" { default = 1}


variable "max_scaling_to" { default = 2}
variable "asgname" { default = "dev_asg"} 
variable "availability_zones" { default = ["us-east-1a"]}
variable "vpc_zone_identifier" { default = []}
variable "tags_name" {  default = "kd_insance"}
variable "region" { default = "us-east-1"}
variable "sec_group_name" { default = "kd_sec_group"}
variable "elbname" { default = "kd-elb"}
variable "elb_securitygroupname" { default = "elbsecuritygroup"}

variable "inst_prof_name" {default="kd_prof_name"}
 

variable "role_name" {default="kd_ins_role"}
variable "s3_access_role_name" { default = "kd_s3accessrole"}
variable "s3_access_policy_name" { default = "kd_s3accesspolicy"}
variable "s3_access_profile_name" { default = "kd_s3_profile"}








