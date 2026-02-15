variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "name" {
  type        = string
  description = "Composer environment name"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "Region"
}

variable "network" {
  type        = string
  description = "VPC network name"
}

variable "subnetwork" {
  type        = string
  description = "Subnetwork name"
}

variable "network_project_id" {
  type        = string
  default     = ""
  description = "Project ID of shared VPC host (if using shared VPC)"
}

variable "subnetwork_region" {
  type        = string
  default     = ""
  description = "Subnetwork region (for shared VPC)"
}

variable "service_account" {
  type        = string
  default     = null
  description = "Service account for Composer nodes (null = default)"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Labels"
}

variable "tags" {
  type        = set(string)
  default     = []
  description = "Tags for node VMs"
}

variable "image_version" {
  type        = string
  default     = "composer-2.10.2-airflow-2.10.2"
  description = "Composer/Airflow image version"
}

variable "environment_size" {
  type        = string
  default     = "ENVIRONMENT_SIZE_MEDIUM"
  description = "ENVIRONMENT_SIZE_SMALL, ENVIRONMENT_SIZE_MEDIUM, ENVIRONMENT_SIZE_LARGE"
}

variable "pypi_packages" {
  type        = map(string)
  default     = {}
  description = "PyPI packages to install"
}

variable "env_variables" {
  type        = map(string)
  default     = {}
  description = "Airflow environment variables"
}

variable "airflow_config_overrides" {
  type        = map(string)
  default     = {}
  description = "Airflow config overrides"
}

variable "grant_sa_agent_permission" {
  type        = bool
  default     = true
  description = "Grant Composer Service Agent role (required for creation)"
}

variable "scheduler" {
  type = object({
    cpu        = string
    memory_gb  = number
    storage_gb = number
    count      = number
  })
  default = {
    cpu        = "2"
    memory_gb  = 7.5
    storage_gb = 5
    count      = 2
  }
  description = "Scheduler workload config"
}

variable "web_server" {
  type = object({
    cpu        = string
    memory_gb  = number
    storage_gb = number
  })
  default = {
    cpu        = "2"
    memory_gb  = 7.5
    storage_gb = 5
  }
  description = "Web server workload config"
}

variable "worker" {
  type = object({
    cpu        = string
    memory_gb  = number
    storage_gb = number
    min_count  = number
    max_count  = number
  })
  default = {
    cpu        = "2"
    memory_gb  = 7.5
    storage_gb = 5
    min_count  = 2
    max_count  = 6
  }
  description = "Worker workload config"
}
