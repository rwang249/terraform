# ################################
# # Cluster Variables #
# ################################
variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
}

variable "region" {
  description = "The region to host the cluster in"
}

variable "issue_client_certificate" {
  description = "issue_client_certificate"
  default = "false"
}

variable "release_channel" {
  default = "REGULAR"
}

variable "default_max_pods_per_node" {
  description = "The max number of pods / node. Out of the box GKE is 110."
  default = "60"
}

variable "labels" {
  default = null
}

variable "network" {
  description = "The name or self_link of the Google Compute Engine network to which the cluster is connected."
}

variable "subnetwork" {
  description = "The name or self_link of the Google Compute Engine subnetwork in which the cluster's instances are launched."
}
variable "pod_ip_range" {
  description = "The IP address range for the cluster pod IPs in this cluster."
}

variable "service_ip_range" {
  description = "The IP address range of the services IPs in this cluster."
}
variable "master_auth_network" {
  description = "Master Auth Network 1"
}
variable "enable_private_endpoint" {
  description = "When true, the cluster's private endpoint is used as the cluster endpoint and access through the public endpoint is disabled"
}
variable "enable_private_nodes" {
  description = "Enables the private cluster feature, creating a private endpoint on the cluster."
}
variable "master_ip_range" {
  description = "The IP range in CIDR notation to use for the hosted master network"
}

##---------------------------------------------##

# ################################
# # Resource Usage #
# ################################
variable "enable_network_egress_metering" {
  description = "Whether to enable network egress metering for this cluster."
  default = false 
}

variable "enable_resource_consumption_metering" {
  description = "Whether to enable resource consumption metering on this cluster"
  default = true
}
variable "usage_metering_dataset" {
  description = "The ID of a BigQuery Dataset which is destination for resource usage export"
  
}


##-----------------------------------------------##

# ################################
# # Maintainance  #
# ################################

variable "start_time" {
  description = "start time for the maintenaince window"
  default = "00:00"
  
}
# ################################
# # GKE Auth #
# ################################

variable "security_group" {
  description = "security group for RBAC"
  default = "gke-security-groups@blah.com"

}

##----------####

# ################################
# # Encryption #
# ################################

variable "encryption_state" {
  description = "ENCRYPTED OR DECRYPTED"
  default = "DECRYPTED"
}

variable "encryption_key_name" {
  description = "the key to use to encrypt/decrypt secrets"
}

##-------------------------##

# ################################
# # Add ons #
# ################################

variable "istio_disabled" {
  description = "To enable Istio, set this variable to false"
}

##----------------#

# ################################
# # Pod Security Policy  #
# ################################
variable "psp_enabled" {
  description = "To enable Pod Security Policy (Admission Controller), set this variable to true"
}

# ################################
# # Shielded Instance  #
# ################################
variable "enable_secure_boot" {
  description = "To enable secure boot. (Secure Boot helps ensure that the system only runs authentic software)"
  default ="true"
}

# ################################
# # Network Policy Policy  #
# ################################
variable "network_policy" {
   description = "To enable Network Policy , set this variable to true"
}

variable "network_policy_disabled" {
  description = "To enable Network Policy, set this variable to false"
}

# ################################
# # Node Pool - Defaults #
# ################################
variable "nodepool_name" {
  description = "Name of the node pool"
}

variable "preemptible" {
  description = "Flag to use preemptible nodes. true or false"
  default = false
}
variable "machine_type" {
  description = "Machine type to use for the nodes"

}
variable "num_nodes_per_zone" {
  description = "The number of nodes per zone"
  default = "2"
}

variable "min_node_count" {
  description = "Minimum number of nodes with Autoscaling enabled"
  default = "1"
}

variable "max_node_count" {
  description = "Max number of nodes with autoscaling enabled"
  default = "3"
}

variable "disk_type" {
  description = "pd-standard or pd-ssd. Defaults to pd-standard"
  default = "pd-standard"
}

variable "disk_size" {
  description = "Size of the disk attached to each node, specified in GB"
}

variable "auto_repair" {
  description = "Set auto-repair on the nodes"
  default = true
}

variable "auto_upgrade" {
  description = "Auto upgrade nodes"
  default = true
}

# ################################
# # extra  Node Pool #
# ################################
variable "extra_nodepool_name" {
  description = "Name of the extra node pool"
}

variable "extra_num_nodes_per_zone" {
  description = "The number of nodes per zone"
}

variable "extra_min_node_count" {
  description = "Minimum number of nodes with Autoscaling enabled"
}

variable "extra_machine_type" {
  description = "Machine type to use for the nodes"
  
}
variable "extra_max_node_count" {
  description = "Max number of nodes with autoscaling enabled"
}

##-----------------------------------------------##
