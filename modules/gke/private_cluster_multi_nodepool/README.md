# GKE Cluster creation with terraform

This repo contains terraform code to create GKE clusters. 

To run:
Please refer to the dev folder structure. Following files are required:
```
├── backend.tf
├── main.tf
├── output.tf
└── variables.tf
```

File Description:
```
backend.tf - defines the remote state location
main.tf - calls the module 
output.tf - defines what gets outputted end of the terraform run
variables.tf - variables to be passed to the module. 
```

Run terraform init to download modules and sanity check the structure
```
terraform init
```
Run terraform plan to look what will be provisioned
```
terraform plan
```

Run terraform apply to provision

```
terraform apply
```

Following variables are needed by this module.: 


|  Variable |  Description | Default  | 
|-----------|--------------|----------|
|  project_id |    The project ID to host the cluster in          |    -      | 
|    cluster_name       |  Name of the GKE cluster            |   -       | 
|  region         |    The region to host the cluster in          |    -      | 
|  issue_client_certificate |  -      | false |
|  psp_enabled  | To enabled Pod Security Policy (Admission Controller), set this variable to true | true |
|  network_policy | To enable or disable Kubernetes Network Policies | true |
|  network_policy_disabled | To enable or disable Kubernetes Network Policies. Set this to false to enable it | false |
|  master_auth_network | External networks that can access the Kubernetes cluster master through HTTPS |  -  |
|  master_auth_network1 | External networks that can access the Kubernetes cluster master through HTTPS |  -  |
|  master_auth_network2 | External networks that can access the Kubernetes cluster master through HTTPS |  -  |
|  master_auth_network1_name | Name of network 1 (External networks that can access the Kubernetes cluster master through HTTPS) |  -  |
|  master_auth_network2_name | Name of network 2 (External networks that can access the Kubernetes cluster master through HTTPS) |  -  |
|  network |  The name or self_link of the Google Compute Engine network to which the cluster is connected | default |
|  subnetwork | The name or self_link of the Google Compute Engine subnetwork in which the cluster's instances are launched  | default |
|  pod_ip_range | The IP address range for the cluster pod IPs in this cluster.   |    |
|  service_ip_range | The IP address range of the services IPs in this cluster. |   |
|  enable_private_nodes | Enables the private cluster feature, creating a private endpoint on the cluster | true |
|  enable_private_endpoint | When true, the cluster's private endpoint is used as the cluster endpoint and access through the public endpoint is disabled | false  |
|  master_ip_range | The IP range in CIDR notation to use for the hosted master network |   |
|  enable_network_egress_metering | Whether to enable network egress metering for this cluster | true |
|  enable_resource_consumption_metering | Whether to enable resource consumption metering on this cluster   | true |
|  usage_metering_dataset  |   The ID of a BigQuery Dataset which is destination for resource usage export |   |
|  enable_secure_boot  |   To enable secure boot. (Secure Boot helps ensure that the system only runs authentic software) | true  |
|  start_time | start time for the maintenaince window  | 04:00  |  
|  encryption_state | Encrypt Application layer secrets. Possible values: ENRYPTED OR DECRYPTED |  ENCRYPTED |
|  encryption_key_name | full self link to the key to use to encrypt/decrypt secrets |   |
|  istio_disabled | To enable Istio, set this variable to false | false |
|  nodepool_name | Name of the node pool (managed by terraform) |  |
|  preemptible | Flag to use preemptible nodes | false |
|  machine_type | Machine type to use for the nodes | |
|  num_nodes_per_zone | The number of nodes per zone |  |
|  min_node_count | Minimum number of nodes with autoscaling enabled |  |
|  max_node_count | Maximum number of nodes with autoscaling enabled |  |
|  disk_type | pd-standard or pd-ssd. Defaults to pd-standard | pd-standard |
|  disk_size | Size of the disk on the nodes (in GB) |  |
|  auto_repair | Enable auto-repair on the nodes |  true |
|  auto_upgrade | Allow auto updates for the nodes | true |
