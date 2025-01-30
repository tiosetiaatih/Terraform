output "instance_id" {
  description = "ID of the created instance"
  value       = alicloud_instance.rocky_vm.id
}

output "public_ip" {
  description = "Public IP address of the created instance"
  value       = alicloud_instance.rocky_vm.public_ip
}

output "private_ip" {
  description = "Private IP address of the created instance"
  value       = alicloud_instance.rocky_vm.private_ip
}