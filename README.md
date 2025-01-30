# Terraform Commands Guide

This document provides instructions on how to use Terraform commands for initializing, planning, applying, and destroying infrastructure.

---

## Basic Commands

### Initialize Terraform
```bash
terraform init
```

### Plan Terraform Changes
```bash
terraform plan
```

### Apply Terraform Changes
```bash
terraform apply
```

### Destroy Terraform Infrastructure
```bash
terraform destroy
```

---

## Commands with Manual Variable Declaration

If the required variables are not declared in the `terraform.tfvars` file, use the following commands with manual variable assignment:

### Initialize Terraform
```bash
terraform init
```

### Plan Terraform Changes
```bash
terraform plan \
  -var="project_id=your_name_project" \
  -var="subnet=your_subnetwork" \
  -var="private_ip=your_priv_ip"
```

### Apply Terraform Changes
```bash
terraform apply \
  -var="project_id=your_name_project" \
  -var="subnet=your_subnetwork" \
  -var="private_ip=your_priv_ip"
```

### Destroy Terraform Infrastructure
```bash
terraform destroy \
  -var="project_id=your_name_project" \
  -var="subnet=your_subnetwork" \
  -var="private_ip=your_priv_ip"

## Commands if we want to create Instance more than 1

Add Count index in main.tf
```bash
resource "google_compute_instance" "vm_instance" {
  count        = 5
  name         = "test-terraform-${count.index + 1}"
  machine_type = var.machine_type
  zone         = var.zone
```

in networks

```bash
network_interface {
    subnetwork = var.subnet
    network_ip = cidrhost("172.16.4.0/24", 60 + count.index)
    stack_type = "IPV4_ONLY"
  }
```