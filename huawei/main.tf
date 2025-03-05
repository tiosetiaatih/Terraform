# Configure the HUAWEI CLOUD provider.
provider "huaweicloud" {
  region     = "ap-southeast-4"
  access_key = "access_key"
  secret_key = "secret_key"
}

# Create a VM Instances
data "huaweicloud_availability_zones" "az1" {}

data "huaweicloud_compute_flavors" "myflavor" {
  availability_zone = data.huaweicloud_availability_zones.az1.names[0]
  performance_type  = "normal"
  cpu_core_count    = 1
  memory_size       = 2
}

data "huaweicloud_vpc_subnet" "mynet" {
  name = "mynet"
}

data "huaweicloud_images_image" "myimage" {
  name        = "Rocky Linux 8.8 64bit"
  most_recent = true
}

data "huaweicloud_networking_secgroup" "mysecgroup" {
  name = "mysecgroup"
}

# Enterprise Project
data "huaweicloud_enterprise_project" "myproject" {
  name = "myproject"
}

resource "huaweicloud_compute_instance" "test-terraform" {
  name               = "test-terraform"
  image_id           = data.huaweicloud_images_image.myimage.id
  flavor_id          = data.huaweicloud_compute_flavors.myflavor.ids[0]
  availability_zone  = data.huaweicloud_availability_zones.az1.names[0]
  security_group_ids = [data.huaweicloud_networking_secgroup.mysecgroup.id]
  admin_pass         = "123#password"
  system_disk_type   = "SAS"
  system_disk_size   = 50

  network {
    uuid = data.huaweicloud_vpc_subnet.mynet.id
  }

  tags = {
    tags = "tags"
  }

  enterprise_project_id = data.huaweicloud_enterprise_project.myproject.id
}