resource "aws_vpc" "kd_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.vpc_tenancy}"

  tags = {
    Name = "kd_vpc"
  }
}

resource "aws_subnet" "kd_subnet" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.subnet_cidr}"

  tags = {
    Name = "subnet1"
  }
}

output "vpc_id" {
  value = "${aws_vpc.kd_vpc.id}"
}
output "subnet_id" {
  value = "${aws_subnet.kd_subnet.id}"
}
