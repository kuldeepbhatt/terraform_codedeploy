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


