# Configure the HUAWEI CLOUD provider.
provider "huaweicloud" {
  region     = "your-region"
  access_key = "your-access-key"
  secret_key = "your-secret-key"
}

# Create a VPC.
resource "huaweicloud_vpc" "vpc" {
  name = "terraform_vpc"
  cidr = "192.168.0.0/16"
}

# Create a VM Instances
resource "huaweicloud_compute_instance" "vm_instance" {
  name              = "test-terraform"
  image_id          = "477723dd-1464-4c3c-9c78-f18fca5b58a4" #Image ID Rocky Linux
  flavor_id         = "s3.medium.1"
  admin_pass        = "your-password-here"
  security_groups   = ["default"]
  availability_zone = "ap-southeast-4a"

  network {
    uuid = "your-id-network"
  }

  system_disk_type = "SAS"
  system_disk_size = 20

  tags = {
    environment = "development"
    os          = "rocky-linux"
    iaac        = "terraform"
  }
}