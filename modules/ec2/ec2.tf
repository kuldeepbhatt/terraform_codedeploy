resource "aws_instance" "kd_ec2" {
    count = "${var.count}"
    ami           = "${var.ami_id}"
    instance_type = "${var.instanceType}"
    subnet_id = "${var.subnet_id}"

    tags = {
        Name = "EC2"
    }
}

output "ami_id" {
  value = "${aws_instance.kd_ec2.id}"
}
