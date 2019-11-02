output "instance_ips" {
  value = ["${aws_instance.test-inst.*.public_ip}"]
}
