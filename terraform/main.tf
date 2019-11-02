provider "aws" {
  # Credentials to access aws cluster
#  access_key = "${var.access_key}"
#  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

data "aws_subnet_ids" "example" {
  vpc_id = "vpc-79ccb903"
}

#data "aws_subnet" "example" {
#  count = "${length(data.aws_subnet_ids.example.ids)}"
#  id    = "${data.aws_subnet_ids.example.ids[count.index]}"
#}
#

resource "aws_lb" "test-lb" {
  name = "test-lb-tf"
  internal = false
  load_balancer_type = "application"
  subnets = [
	"subnet-c5e884fb",
	"subnet-17eb035a",
	]	
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = "${aws_lb_target_group.test.arn}"
  target_id        = "${aws_instance.test-inst.0.id}"
  port             = 80
depends_on = [aws_lb_target_group.test,
	     aws_instance.test-inst,]

}


resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = "vpc-79ccb903"
depends_on = [aws_instance.test-inst]
}



resource "aws_instance" "test-inst" {
  instance_type = "${var.instance_type}"
  ami           = "${var.ami}"
  count         = 1
  key_name      = "demo-keypair"
  subnet_id     = "${var.subnet_id}"
  associate_public_ip_address = "${var.associate_public_ip_address}"

}

