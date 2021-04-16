### project specific ###

variable "project_id" {
  description = "The project ID to deploy resources into"
  default = "test"
}

variable "region" {
  default = "northamerica-northeast1"
}

variable "network_self_link" {
  default = "projects/hostVPCProject/global/networks/test-vpc"
}

variable "network" {
  default = "projects/hostVPCProject/global/networks/test-vpc"
}

variable "subnetwork" {
  description = "The name of the subnetwork to deploy instances into"
  default = "projects/hostVPCProject/regions/northamerica-northeast1/subnetworks/test-subnet"
}

variable "subnetwork_project" {
  description = "The project that subnetwork belongs to"
  default     = "hostVPCProject"
}


########################################
#should be changed for each new cluster#
########################################
variable "name" {
  default = null
}

variable "master_cidr_block" {
  default = null
}

variable "cluster_cidr_block" {
  default = null
}

variable "cluster_secondary_range_name" {
  default = "test-k8s-pods"
}

variable "services_secondary_range_name" {
  default = "test-k8s-services"
}

variable "subnetwork_name" {
  default = "projects/hostVPCProject/regions/northamerica-northeast1/subnetworks/test-subnet"
}

variable "dataset_id" {
  default = "foo"
}

variable "encryption_key" {
  default = "projects/test/locations/northamerica-northeast1/keyRings/test-k8s-keyring/cryptoKeys/test-k8s-key"
}

##########################################################

variable "remove_default_node_pool" {
  default = "true"
}

variable "initial_node_count" {
  default = "1"
}

variable "client_certificate" {
  default = "false"
}

variable "master_auth_network" {
  default = "10.0.0.0/8"
}

variable "monitoring_service" {
  default = "monitoring.googleapis.com/kubernetes"
}

variable "logging_service" {
  default = "logging.googleapis.com/kubernetes"
}

variable "disable_network_policy_config" {
  default = "true"
}

variable "enable_private_nodes" {
  default = "true"
}

variable "enable_private_endpoint" {
  default = "false"
}

variable "enable_network_policy" {
  default = "false"
}

variable "network_egress_metering" {
  default = "false"
}

variable "create_subnetwork" {
  default = "false"
}

variable "encryption_state" {
  default = "ENCRYPTED"
}

variable "maintenance_start_time" {
  default = "04:00"
}

variable "node_pool_name" {
  default = "default-pool"
}

variable "auto_repair" {
  default = "true"
}

variable "auto_upgrade" {
  default = "true"
}

variable "general_purpose_min_node_count" {
  default = 1
}

variable "general_purpose_max_node_count" {
  default = 3
}

variable "general_purpose_machine_type" {
  default = "n1-standard-4"
  description = "Machine type to use for the general-purpose node pool. See https://cloud.google.com/compute/docs/machine-types"
}

variable "disable_legacy_endpoints" {
  default = "true"
}

######################
#GCE
variable "vm_name" {
  description = "Virtual Machine Name"
  default = "testvm"
}

variable "vm_machine_type" {
  description = "VM Machine Type"
  default = "n1-standard-1"
}

variable "instance_name" {
  description = "The desired name to assign to the deployed instance"
  default     = "testvm"
}

variable "zone" {
  description = "The GCP zone to deploy instances into"
  default = "northamerica-northeast1-b"
}


variable "vm_image" {
  description = "Image to use for VM"
  default = "centos-7-v20180129"
}

variable "ip_forward" {
  description = "Image to use for VM"
  default = "false"
}
########################
#KMS
########################

variable "keyring" {
  description = "Keyring name."
  type        = list(string)
  default     = []
}

variable "keys" {
  description = "Key names."
  type        = list(string)
  default     = []
}
########################
#BigQuery
########################

variable "delete_contents_on_destroy" {
  description = "(Optional) If set to true, delete all the tables in the dataset when destroying the resource; otherwise, destroying the resource will fail if tables are present."
  type        = bool
  default     = null
}
