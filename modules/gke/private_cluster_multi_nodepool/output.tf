output "endpoint" {
  value = data.google_container_cluster.k8s_cluster.endpoint
}

output "instance_group_urls" {
  value = data.google_container_cluster.k8s_cluster.instance_group_urls
}

output "node_config" {
  value = data.google_container_cluster.k8s_cluster.node_config
}

output "node_pools" {
  value = data.google_container_cluster.k8s_cluster.node_pool
}