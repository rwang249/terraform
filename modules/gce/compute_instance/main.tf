/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

###############
# Data Sources
###############

data "google_compute_zones" "available" {
  project = var.project_id
  region  = var.region
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

  metadata_startup_script = var.instance_startup_script
  
  labels = var.labels
    
  lifecycle {
    ignore_changes = [attached_disk]
  }
}

