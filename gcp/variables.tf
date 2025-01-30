variable "project_id" {}
variable "region" {
  default = "asia-southeast1"
}
variable "zone" {
  default = "asia-southeast1-b"
}
variable "machine_type" {
  default = "e2-small"
}
variable "boot_disk_size" {
  default = 20
}
variable "boot_disk_type" {
  default = "pd-balanced"
}
variable "subnet" {
  default = "subnet-rnd-01"
}
variable "private_ip" {
  default = "172.16.4.60"
}