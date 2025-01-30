provider "alicloud" {
  region = "ap-southeast-1"  # Ganti dengan region yang diinginkan
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "rocky-vpc"
  cidr_block = "10.0.0.0/16"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id     = alicloud_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  zone_id    = "ap-southeast-1a"  # Ganti dengan zone yang diinginkan
}

resource "alicloud_security_group" "sg" {
  vpc_id = alicloud_vpc.vpc.id
  name   = "rocky-sg"
}

resource "alicloud_security_group_rule" "allow_ssh" {
  security_group_id = alicloud_security_group.sg.id
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "22/22"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_instance" "rocky_vm" {
  instance_name        = "rocky-vm"
  instance_type        = "ecs.t5-lc1m1.small"  # Ganti dengan instance type yang diinginkan
  image_id             = "rocky_linux_9_x64_20G_alibase_20230718.vhd"  # Ganti dengan image ID Rocky Linux yang valid
  vswitch_id           = alicloud_vswitch.vsw.id
  security_groups      = [alicloud_security_group.sg.id]
  internet_max_bandwidth_out = 10  # Bandwidth internet outbound dalam Mbps

  tags = {
    Environment = "Production"
    OS          = "Rocky Linux"
  }
}