###############
# Data Sources
###############

data "google_compute_zones" "available" {
  project = var.project_id
  region  = var.region
}

###############
# Disks
###############
resource "google_compute_disk" "pd" {
  project = var.project_id
  name    = "${var.vm_hostname}-data-disk-1"
  type    = var.vm_additional_disk_type
  zone    = var.zone
  size    = var.vm_additional_disk_size
  description = var.vm_additional_disk_description
  # resource_policies = var.vm_additional_disk_policy
  labels  = var.labels
}
#############
# Instances
#############

resource "google_compute_instance" "compute_instance" {
  name     = var.vm_hostname
  project  = var.project_id
  zone     = var.zone
  machine_type = var.vm_machine_type
  hostname     = "${var.vm_hostname}.blah.com"
  can_ip_forward = var.ip_forward

  network_interface {
    network            = var.network
    subnetwork         = var.subnetwork
    subnetwork_project = var.subnetwork_project
  }

  boot_disk {
    device_name = var.vm_disk_device_name
    initialize_params {
      type = var.vm_disk_type
      image = var.vm_image
    }
  }

  metadata = {
    disable-legacy-endpoints = "true"
  }

  labels = var.labels
  
  lifecycle {
    ignore_changes = [attached_disk]
  }

  depends_on = [ 
    google_compute_disk.pd,
  ]
}

#####################
# Disk Attachment
#####################
resource "google_compute_attached_disk" "default" {
  disk     = "${var.vm_hostname}-data-disk-1"
  instance = google_compute_instance.compute_instance.name
  zone     = var.zone

  depends_on = [ 
    google_compute_disk.pd,
    google_compute_instance.compute_instance,
  ]
}

#####################
# Snapshot Attachment
#####################

resource "google_compute_disk_resource_policy_attachment" "attachment" {
  name = var.vm_additional_disk_policy
  disk = "${var.vm_hostname}-data-disk-1"
  zone = var.zone

  depends_on = [ 
    google_compute_disk.pd,
    google_compute_instance.compute_instance,
  ]
}

