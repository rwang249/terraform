resource "google_compute_instance_group" "instance_group" {
  name        = var.umig_name
  description = var.umig_description
  zone        = var.zone
  network     = var.network
  instances   = var.umig_instances
  dynamic "named_port" {
    for_each = var.named_ports
    content {
      name = named_port.value.name
      port = named_port.value.port
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}