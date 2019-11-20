output "instance_ips" {
  value = ["${aws_instance.webt.*.public_ip}"]
}
