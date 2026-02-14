variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "zone" {
  description = "GCP zone for the instance (e.g. asia-south1-a)"
  type        = string
}

variable "instance_name" {
  description = "Name of the Compute Engine instance"
  type        = string
}

variable "machine_type" {
  description = "Machine type (e.g. e2-medium, n2-standard-4)"
  type        = string
  default     = "e2-medium"
}

variable "boot_disk_size_gb" {
  description = "Boot disk size in GB"
  type        = number
  default     = 10
}

variable "boot_disk_type" {
  description = "Boot disk type (pd-standard, pd-balanced, pd-ssd)"
  type        = string
  default     = "pd-standard"
}

variable "gcp_image" {
  description = "Image name or self link (e.g. ubuntu-os-cloud/ubuntu-2204-lts or full self_link)"
  type        = string
  default     = ""
}

variable "subnetwork" {
  description = "Subnetwork self link or name (e.g. projects/PROJECT/regions/REGION/subnetworks/NAME or default)"
  type        = string
}

variable "subnetwork_project" {
  description = "Project of the subnetwork; defaults to project_id"
  type        = string
  default     = null
}

variable "network_tags" {
  description = "List of network tags"
  type        = list(string)
  default     = []
}

variable "labels" {
  description = "Labels for the instance"
  type        = map(string)
  default     = {}
}

variable "metadata" {
  description = "Metadata key-value pairs (ssh-keys can be set via ssh_keys variable)"
  type        = map(string)
  default     = {}
}

variable "ssh_keys" {
  description = "SSH public keys for metadata (format: user:key user2:key2)"
  type        = string
  default     = null
}

variable "service_account_email" {
  description = "Service account email for the instance"
  type        = string
}

variable "service_account_scopes" {
  description = "Service account scopes"
  type        = list(string)
  default     = ["cloud-platform"]
}

variable "assign_public_ip" {
  description = "Assign a public IP (ephemeral)"
  type        = bool
  default     = false
}

variable "enable_additional_disk" {
  description = "Create and attach an additional data disk"
  type        = bool
  default     = false
}

variable "additional_disk_size_gb" {
  description = "Additional disk size in GB"
  type        = number
  default     = 10
}

variable "additional_disk_type" {
  description = "Additional disk type (pd-standard, pd-balanced, pd-ssd)"
  type        = string
  default     = "pd-standard"
}

variable "attach_local_ssd" {
  description = "Attach a local SSD (scratch disk)"
  type        = bool
  default     = false
}

variable "preemptible" {
  description = "Use a preemptible instance"
  type        = bool
  default     = false
}

variable "spot" {
  description = "Use a spot VM"
  type        = bool
  default     = false
}

variable "automatic_restart" {
  description = "Automatically restart the instance when terminated by GCP"
  type        = bool
  default     = true
}

variable "on_host_maintenance" {
  description = "Behavior on host maintenance (MIGRATE or TERMINATE)"
  type        = string
  default     = "MIGRATE"
}

variable "allow_stopping_for_update" {
  description = "Allow Terraform to stop the instance for updates"
  type        = bool
  default     = true
}
