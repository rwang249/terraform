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

variable "dataproc_cluster_name" {
  description = "Name of Dataproc Cluster"
  default     = ""
}

variable "region" {
  type        = string
  description = "Region where the instances should be created."
  default     = null
}

variable "zone" {
  type        = string
  description = "zone where the instances should be created."
  default     = null
}

variable "network" {
  description = "Network to deploy to. Only one of network or subnetwork should be specified."
  default     = ""
}

variable "subnetwork" {
  description = "Subnet to deploy to. Only one of network or subnetwork should be specified."
  default     = ""
}

variable "labels" {
  description = "The key/value labels for the instance."
  type        = map(string)
  default     = {}
}

variable "dataproc_staging_bucket" {
  type        = string
  description = "Name of DataProc staging bucket"
  default     = null
}

variable "master_instance_num" {
  description = "Default Number of Master Instances"
  default = 1
}

variable "master_machine_type" {
  description = "Cluster Master Machine Type"
  default = "n1-standard-1"
}

variable "master_disk_type" {
  description = "Master Disk Type"
  default = "pd-ssd"
}

variable "master_disk_size" {
  description = "Master Boot Disk Size"
  default = 15
}

variable "worker_instance_num" {
  description = "Default Number of Worker Instances"
  default = 2
}

variable "worker_machine_type" {
  description = "Cluster Worker Machine Type"
  default = "n1-standard-1"
}

variable "worker_disk_size" {
  description = "Worker Boot Disk Size"
  default = 15
}

variable "dataproc_kms_key" {
  description = "KMS key used to encrypt cluster disks"
  default = null
}

variable "dataproc_autoscale_policy" {
  description = "Name of Dataproc Autoscale Policy"
  default = null
}

variable "autoscale_max_instances" {
  description = "Max # of instances Dataproc cluster can autoscale to"
  default = 3
}

variable "autoscale_scale_up_factor" {
  description = "Dataproc cluster scale up factor"
  default = 0.5
}

variable "autoscale_scale_down_factor" {
  description = "Dataproc cluster scale down factor"
  default = 0.5
}