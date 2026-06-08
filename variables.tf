variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "Default region for the provider"
  type        = string
  default     = "us-central1"
}
