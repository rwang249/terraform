resource "google_container_cluster" "primary" {
  provider = google-beta
  name     = var.cluster_name
  location = var.region
  project = var.project_id
  
  

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = var.issue_client_certificate
    }
  }
  default_max_pods_per_node = var.default_max_pods_per_node
  network = var.network
  subnetwork = var.subnetwork

   master_authorized_networks_config {
   
    cidr_blocks {
      display_name = var.master_auth_network1_name
      cidr_block = var.master_auth_network1
      
    }

    cidr_blocks {
      display_name = var.master_auth_network2_name
      cidr_block = var.master_auth_network2
      
    }
    cidr_blocks {
      
      cidr_block = var.master_auth_network
      
    }

  }

  ip_allocation_policy {

    cluster_secondary_range_name  = var.pod_ip_range
    services_secondary_range_name = var.service_ip_range


  }
  release_channel {
    channel = var.release_channel
  }


  private_cluster_config {

   enable_private_nodes = var.enable_private_nodes
   enable_private_endpoint = var.enable_private_endpoint
   master_ipv4_cidr_block = var.master_ip_range
  }
  resource_usage_export_config {
    enable_network_egress_metering = var.enable_network_egress_metering
    enable_resource_consumption_metering = var.enable_resource_consumption_metering
  
    bigquery_destination {
      dataset_id = var.usage_metering_dataset
    }
  }

  pod_security_policy_config {

    enabled = var.psp_enabled

  }

  network_policy {
     enabled = var.network_policy

  }

  maintenance_policy {
   daily_maintenance_window {
    start_time = var.start_time
  }

  }

  authenticator_groups_config {

   security_group = var.security_group

  }
  addons_config {
    istio_config {
      disabled = var.istio_disabled
      
    }
    network_policy_config {
     disabled = var.network_policy_disabled

    }
  }

  workload_identity_config {
    identity_namespace = "${var.project_id}.svc.id.goog"
  }

  enable_intranode_visibility = "true"
  enable_shielded_nodes = "true"

  database_encryption {

  state = var.encryption_state
  key_name = var.encryption_key_name

  }
  
  resource_labels  = var.labels

  lifecycle {
    ignore_changes = [node_pool, initial_node_count, resource_labels]
  }
}

resource "google_container_node_pool" "default_node_pool" {
  provider   = google-beta
  name       = var.nodepool_name
  location   = var.region
  cluster    = google_container_cluster.primary.name
  initial_node_count = var.num_nodes_per_zone
  

  node_config {
    preemptible  = var.preemptible
    machine_type = var.machine_type
    disk_type = var.disk_type
    disk_size_gb = var.disk_size
    shielded_instance_config {

        enable_secure_boot = var.enable_secure_boot

    }
    workload_metadata_config {

        node_metadata = "GKE_METADATA_SERVER"
    }
  
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
    ]
  }
  management {

    auto_repair = var.auto_repair
    auto_upgrade = var.auto_upgrade

  }

  autoscaling {
    
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count

  }

}

resource "google_container_node_pool" "extra_node_pool" {
  provider   = google-beta
  name       = var.extra_nodepool_name
  location   = var.region
  cluster    = google_container_cluster.primary.name
  initial_node_count = var.extra_num_nodes_per_zone
  

  node_config {
    preemptible  = var.preemptible
    machine_type = var.extra_machine_type
    disk_type = var.disk_type
    disk_size_gb = var.disk_size
    shielded_instance_config {

        enable_secure_boot = var.enable_secure_boot

    }
    workload_metadata_config {

        node_metadata = "GKE_METADATA_SERVER"
    }

    taint {
       key = "dedicated"
       value = "extra"
       effect = "NO_SCHEDULE"

    }
  
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
    ]
  }
  management {

    auto_repair = var.auto_repair
    auto_upgrade = var.auto_upgrade

  }

  autoscaling {
    
    min_node_count = var.extra_min_node_count
    max_node_count = var.extra_max_node_count

  }

}

}

data "google_container_cluster" "k8s_cluster" {
  name     = var.cluster_name
  location = var.region
  depends_on = [
    google_container_node_pool.default_node_pool,
    google_container_node_pool.extra_node_pool,
    google_container_node_pool.eaccess_node_pool,
    google_container_node_pool.donna_node_pool,
    google_container_cluster.primary,
  ]
}
