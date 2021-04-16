variable "project_id" {
  type        = string
  description = "The GCP project ID"
  default     = null
}

variable "region" {
  description = "The GCP region where the managed instance group resides."
}