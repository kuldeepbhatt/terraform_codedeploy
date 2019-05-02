variable "codedepappname" { default = "nodedemoapp"}
variable "depgroupname" { default = "nodeappdepgroup"}
variable "iamrolename" { default = "codedeprole"}
variable "deptype" { default = "CodeDeployDefault.OneAtATime" }
variable "s3_tf_bckt_name" { default = "kdtfbckt"}

variable "visibility" { default = "public"}
variable "s3_bckt_name" {}
variable "env" { default = "dev"}

variable "instance_tag" {}




