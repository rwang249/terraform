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

variable "network" {
  description = "Network to deploy to. Only one of network or subnetwork should be specified."
  default     = ""
}

variable "subnetwork" {
  description = "Subnet to deploy to. Only one of network or subnetwork should be specified."
  default     = ""
}

variable "subnetwork_project" {
  description = "The project that subnetwork belongs to"
  default     = ""
}

variable "vm_hostname" {
  description = "Hostname of instances"
  default     = ""
}

variable "region" {
  type        = string
  description = "Region where the instances should be created."
  default     = null
}

variable "project_id" {
  type        = string
  description = "Default Project ID"
  default     = null
}

variable "vm_image" {
  description = "Image to use for VM"
  default = null
}

variable "ip_forward" {
  description = "Image to use for VM"
  default = "false"
}

variable "vm_machine_type" {
  description = "VM Machine Type"
  default = "n1-standard-1"
}

variable "vm_disk_type" {
  description = "VM Disk Type"
  default = "pd-ssd"
}

variable "vm_disk_device_name" {
  description = "VM Boot Disk"
  default = "root"
}

variable "labels" {
  description = "The key/value labels for the instance."
  type        = map(string)
  default     = {}
}

variable "zone" {
  description = "Zone instance will be provisioned in"
  default = null
}

variable "vm_additional_disk_size" {
  description = "Size of additional VM disk(GB)"
  default = "10"
}

variable "vm_additional_disk_type" {
  description = "VM Additional Disk Type"
  default = "pd-ssd"
}

variable "vm_additional_disk_description" {
  description = "VM Additonal Disk Description"
  default = "Additional Disk"
}

variable "vm_additional_disk_policy" {
  description = "VM Additional Snapshot Policy"
  default = "tier-3"
}