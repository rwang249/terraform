###############
# Cluster
###############

resource "google_dataproc_cluster" "dataproc_cluster" {
  name     = var.dataproc_cluster_name
  region   = var.region
  labels   = var.labels

  cluster_config {
    staging_bucket = var.dataproc_staging_bucket

    master_config {
      num_instances = var.master_instance_num
      machine_type  = var.master_machine_type
      disk_config {
        boot_disk_type    = var.master_disk_type
        boot_disk_size_gb = var.master_disk_size
      }
    }

    worker_config {
      num_instances    = var.worker_instance_num
      machine_type     = var.worker_machine_type
      min_cpu_platform = "Intel Skylake"
      disk_config {
        boot_disk_size_gb = var.worker_disk_size
        num_local_ssds    = 1
      }
    }

    preemptible_worker_config {
      num_instances = 0
    }

    # Override or set some custom properties
    software_config {
      #image_version = "1.3.7-deb9"
      override_properties = {
        "dataproc:dataproc.allow.zero.workers" = "true"
      }
    }

    gce_cluster_config {
      #tags = [""]
      service_account_scopes = [
        "https://www.googleapis.com/auth/monitoring",
        "useraccounts-ro",
        "storage-rw",
        "logging-write",
      ]
      internal_ip_only = "true"
      zone = var.zone
      subnetwork = var.subnetwork
    }
    
    encryption_config {
      kms_key_name = var.dataproc_kms_key
    }
    # You can define multiple initialization_action blocks
    # initialization_action {
    #   script      = "gs://dataproc-initialization-actions/stackdriver/stackdriver.sh"
    #   timeout_sec = 500
    # }
  }
}

resource "google_dataproc_autoscaling_policy" "asp" {
  policy_id = var.dataproc_autoscale_policy
  location  = var.region

  worker_config {
    max_instances = var.autoscale_max_instances
  }

  basic_algorithm {
    yarn_config {
      graceful_decommission_timeout = "30s"

      scale_up_factor   = var.autoscale_scale_up_factor
      scale_down_factor = var.autoscale_scale_down_factor
    }
  }
}
