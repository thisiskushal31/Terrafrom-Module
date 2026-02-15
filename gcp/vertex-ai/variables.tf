variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "Region (e.g. us-central1)"
}

# Dataset
variable "create_dataset" {
  type        = bool
  default     = false
  description = "Create a Vertex AI dataset"
}

variable "dataset_display_name" {
  type        = string
  default     = ""
  description = "Dataset display name (required when create_dataset = true)"
}

variable "dataset_metadata_schema_uri" {
  type        = string
  default     = "gs://google-cloud-aiplatform/schema/dataset/metadata/image_1.0.0.yaml"
  description = "Metadata schema URI for the dataset"
}

variable "dataset_labels" {
  type        = map(string)
  default     = {}
  description = "Dataset labels"
}

# Endpoint
variable "create_endpoint" {
  type        = bool
  default     = false
  description = "Create a Vertex AI endpoint (for model deployment)"
}

variable "endpoint_name" {
  type        = string
  default     = ""
  description = "Endpoint name (must be unique in project/region; required when create_endpoint = true)"
}

variable "endpoint_display_name" {
  type        = string
  default     = ""
  description = "Endpoint display name"
}

variable "endpoint_description" {
  type        = string
  default     = ""
  description = "Endpoint description"
}

variable "endpoint_labels" {
  type        = map(string)
  default     = {}
  description = "Endpoint labels"
}
