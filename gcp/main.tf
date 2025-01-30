provider "google" {
  project      = var.project_id
  region       = var.region
  zone         = var.zone
  credentials  = file("~/.config/gcloud/your-service-account.json")
}

resource "google_compute_instance" "vm_instance" {
  count        = 5
  name         = "test-terraform-${count.index + 1}"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "projects/rocky-linux-cloud/global/images/rocky-linux-8-optimized-gcp-v20241210" # Rocky Linux Image
      size  = var.boot_disk_size
      type  = var.boot_disk_type
    }
    device_name = "test-terraform-${count.index + 1}-disk"
  }

  network_interface {
    subnetwork = var.subnet
    network_ip = cidrhost("172.16.4.0/24", 60 + count.index)
    stack_type = "IPV4_ONLY"
  }

  labels = {
    project = "terraform"
  }

  tags = ["terraform"]
}