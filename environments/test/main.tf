provider "null" {
  version = "~> 2.1"
}

provider "random" {
  version = "~> 2.2"
}

############################### GKE ################################

module "test-k8s" {
  source   = "../../modules/gke/private_cluster_multi_nodepool"
  project_id  = var.project_id
  cluster_name = "test-k8s"
  region   = var.region
  network = "projects/hostVPCProject/global/networks/om-test-vpc"
  subnetwork = "projects/hostVPCProject/regions/northamerica-northeast1/subnetworks/om-test-k8s-hosts"
  pod_ip_range = "test-k8s-pods"
  service_ip_range = "test-k8s-services"
  master_ip_range = "172.16.0.0/28"
  master_auth_network = "10.0.0.0/8"
  disk_size = 100
  istio_disabled = "true"
  issue_client_certificate = "false"
  usage_metering_dataset = var.dataset_id
  encryption_key_name = "projects/test/locations/northamerica-northeast1/keyRings/test-k8s-keyring/cryptoKeys/test-k8s-key"
  encryption_state = "ENCRYPTED"
  network_policy = "true"
  network_policy_disabled = "false"
  enable_private_nodes = "true"
  enable_private_endpoint = "false"
  psp_enabled = "false"

  labels = {
    environment = "test"
    cost_center = "test"
  } 

  ####Default NodePool####
  nodepool_name = "default-test-k8s-nodepool"
  num_nodes_per_zone = 1
  min_node_count = 1
  machine_type = "n1-standard-8"
  max_node_count = 4

  ####extra NodePool####
  extra_nodepool_name = "extra-test-k8s-nodepool"
  extra_num_nodes_per_zone = 1
  extra_min_node_count = 1
  extra_machine_type = "n1-standard-16"
  extra_max_node_count = 4

}

################################## GCE ############################################
module "snapshot-schedule" {
  source            = "../../modules/gce/snapshot_schedule"
  project_id        = var.project_id
  region            = var.region
}

module "testvm" {
  source            = "../../modules/gce/compute_instance"
  project_id        = var.project_id
  region            = var.region
  zone              = "northamerica-northeast1-b"
  subnetwork        = var.subnetwork
  vm_hostname       = "testvm"
  vm_machine_type   = "n1-standard-2"
  vm_image = "projects/test/global/images/blah-rhel-7"
  ip_forward = "true"
  
  labels = {
    project = "test"
    application = "test"
    component = "server"
    environment = "test"
  }

  instance_startup_script = file("../../modules/gce/compute_instance/startup_scripts/test.sh")
}


module "testvm02" {
  source            = "../../modules/gce/compute_instance_with_additional_disks"
  project_id        = var.project_id
  region            = var.region
  zone              = "northamerica-northeast1-a"
  subnetwork        = var.subnetwork
  vm_hostname       = "testvm02"
  vm_machine_type   = "n2-standard-16"
  vm_image = "projects/test/global/images/blah-rhel-7"
  vm_additional_disk_type = "pd-ssd"
  vm_additional_disk_size = "100"
  vm_additional_disk_description = "/u01"
  
  labels = {
    project = "test"
    application = "test"
    component = "server"
    environment = "test"
  }
}
##################################UMIG############################################

module "test-umig-nae1-a" {
  source = "../../modules/gce/unmanaged_instance_group"
  umig_name        = "test-umig-nae1-a"
  umig_description = "Unmanaged Instance Group for test servers in nae1-a"
  zone        = "northamerica-northeast1-a"
  network     = var.network
  umig_instances   = ["projects/test/zones/northamerica-northeast1-a/instances/testvm02"]
  named_ports = [
      {
        name = "http"
        port = "80"
      },
      {
        name = "https"
        port = "443"
      }
  ]
}


##################################ILB############################################
module "test-ilb" {
  source       = "../../modules/google-lb-internal-tcp-ssl"
  region       = var.region
  name         = "test-ilb"
  #ports        = ["80", "443"]
  ports        = null
  all_ports    = true
  ip_protocol  = "TCP"
  network      = var.network
  subnetwork   = var.subnetwork
  network_project = var.project_id
  backends     = [
    { group = "https://www.googleapis.com/compute/v1/projects/test/zones/northamerica-northeast1-a/instanceGroups/test-umig-nae1-a", description = "test-node-1" },
  ]

  health_check = (
      {
        type                = "ssl"
        check_interval_sec  = 10
        healthy_threshold   = 3
        timeout_sec         = 5
        unhealthy_threshold = 3
        response            = ""
        proxy_header        = "NONE"
        port                = 443
        port_name           = "ssl"
        request             = ""
      }
  )
}


##################################BigQuery############################################
module "test-bigquery" {
  source                     = "../../modules/bigquery/basic"
  dataset_id                 = "foo"
  dataset_name               = "foo"
  description                = "some description"
  project_id                 = var.project_id
  location                   = "northamerica-northeast1"
  delete_contents_on_destroy = var.delete_contents_on_destroy
  dataset_labels = {
    env      = "test"
    billable = "true"
    owner    = "test"
  }
}

#################################KMS############################################
module "test-kms" {
  source     = "../../modules/kms/basic"
  project_id = var.project_id
  keyring    = "test-keyring"
  location   = "northamerica-northeast1"
  keys       = ["test-key"]

  # keys can be destroyed by Terraform
  prevent_destroy = false
}

module "test-k8s-kms" {
  source     = "../../modules/kms/basic"
  project_id = var.project_id
  keyring    = "test-k8s-keyring"
  location   = "northamerica-northeast1"
  keys       = ["test-k8s-key"]

  # keys can be destroyed by Terraform
  prevent_destroy = false
}
#########################################PSQL###########################################
module "postgres-test" {
  source           = "../../modules/cloudsql/postgresql"
  name             = "postgres-test"
  project_id       = var.project_id
  database_version = "POSTGRES_11"
  region           = var.region
  deletion_protection = "true"

  // Master configurations
  tier                            = "db-custom-2-7680"
  zone                            = "c"
  availability_type               = "REGIONAL"
  maintenance_window_day          = 7
  maintenance_window_hour         = 2
  maintenance_window_update_track = "stable"

  database_flags = [
    {
      name  = "autovacuum"
      value = "on"
    },
    {
      name  = "cloudsql.enable_pgaudit"
      value = "on"
    },
    {
      name  = "pgaudit.log"
      value = "all"
    },
  ]

  user_labels = {
    project = "test"
    environment = "test"
    createdby = "test"
  }

  ip_configuration = {
    ipv4_enabled    = false
    require_ssl     = false
    private_network = var.network_self_link
    authorized_networks = [
      {
        name  = "${var.project_id}-cidr"
        value = var.pg_ha_external_ip_range
      },
    ]
  }

  backup_configuration = {
    enabled    = true
    start_time = "02:00"
    location = "us"
    point_in_time_recovery_enabled = false
  }

  // Read replica configurations
  read_replica_name_suffix                     = "S"
  read_replica_size                            = 0
  read_replica_tier                            = "db-custom-2-7680"
  read_replica_zones                           = "a,b,c"
  read_replica_activation_policy               = "ALWAYS"
  read_replica_crash_safe_replication          = true
  read_replica_disk_autoresize                 = true
  read_replica_disk_type                       = "PD_HDD"
  read_replica_replication_type                = "SYNCHRONOUS"
  read_replica_maintenance_window_day          = 7
  read_replica_maintenance_window_hour         = 23
  read_replica_maintenance_window_update_track = "stable"

  read_replica_user_labels = {
    project = "test"
    environment = "test"
    createdby = "test"
  }

  read_replica_database_flags = [
    {
      name  = "autovacuum"
      value = "off"
    },
  ]

  read_replica_configuration = {
    dump_file_path            = "gs://${var.project_id}.appspot.com/tmp"
    connect_retry_interval    = 5
    ca_certificate            = null
    client_certificate        = null
    client_key                = null
    failover_target           = null
    master_heartbeat_period   = null
    password                  = null
    ssl_cipher                = null
    username                  = null
    verify_server_certificate = null
  }

  read_replica_ip_configuration = {
    ipv4_enabled    = false
    require_ssl     = false
    private_network = var.network_self_link
    authorized_networks = [
      {
        name  = "${var.project_id}-cidr"
        value = var.pg_ha_external_ip_range
      },
    ]
  }
}

##################################DataProc############################################
module "test-dataproc" {
  source     = "../../modules/dataproc/basic-internal"
  dataproc_cluster_name = "test-dataproc"
  dataproc_staging_bucket = ""
  master_instance_num = 1
  master_machine_type = "n1-standard-1"
  master_disk_type = "pd-ssd"
  master_disk_size = 15
  worker_instance_num = 2
  worker_machine_type = "n1-standard-1"
  worker_disk_size = 15
  zone = "northamerica-northeast1-a"
  subnetwork = var.subnetwork
  dataproc_kms_key = "projects/test/locations/northamerica-northeast1/keyRings/test-keyring/cryptoKeys/test-key"
  dataproc_autoscale_policy = "test-autoscale-policy"
  autoscale_max_instances = "3"
  autoscale_scale_up_factor = 0.5
  autoscale_scale_down_factor = 0.5
  labels = {
    env      = "test"
    billable = "true"
    owner    = "test"
  }
}


