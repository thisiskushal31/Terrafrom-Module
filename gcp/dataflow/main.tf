# Flex Template job
resource "google_dataflow_flex_template_job" "job" {
  count    = var.use_flex_template ? 1 : 0
  provider = google-beta

  project                  = var.project_id
  name                     = var.name
  region                   = var.region
  container_spec_gcs_path  = var.container_spec_gcs_path
  temp_location            = var.temp_location
  on_delete                = var.on_delete
  max_workers              = var.max_workers
  parameters               = var.parameters
  labels                   = var.labels
  service_account_email    = var.service_account_email
  network                  = var.network
  subnetwork               = var.subnetwork
  machine_type             = var.machine_type
  ip_configuration         = var.use_public_ips ? "WORKER_IP_PUBLIC" : "WORKER_IP_PRIVATE"
  enable_streaming_engine  = var.enable_streaming_engine
  skip_wait_on_job_termination = var.skip_wait_on_job_termination
  kms_key_name             = var.kms_key_name
  additional_experiments   = var.additional_experiments
}

# Classic template job
resource "google_dataflow_job" "job" {
  count = var.use_flex_template ? 0 : 1

  project                   = var.project_id
  name                      = var.name
  region                    = var.region
  template_gcs_path         = var.template_gcs_path
  temp_gcs_location         = "gs://${var.temp_gcs_location}/tmp_dir"
  on_delete                 = var.on_delete
  max_workers               = var.max_workers
  parameters                = var.parameters
  labels                    = var.labels
  service_account_email     = var.service_account_email
  network                   = var.network
  subnetwork                = var.subnetwork
  machine_type              = var.machine_type
  ip_configuration          = var.use_public_ips ? "WORKER_IP_PUBLIC" : "WORKER_IP_PRIVATE"
  enable_streaming_engine   = var.enable_streaming_engine
  skip_wait_on_job_termination = var.skip_wait_on_job_termination
  kms_key_name              = var.kms_key_name
  additional_experiments    = var.additional_experiments
}
