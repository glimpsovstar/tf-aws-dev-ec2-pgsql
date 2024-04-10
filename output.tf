output "ec2_global_ips" {
  value = ["${aws_instance.rhel-pgsql_instance.*.public_ip}"]
}
