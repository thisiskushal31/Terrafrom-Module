data "google_project" "project" {
  project_id = var.project_id
}

locals {
  cloud_composer_sa = "service-${data.google_project.project.number}@cloudcomposer-accounts.iam.gserviceaccount.com"
  network_project   = var.network_project_id != "" ? var.network_project_id : var.project_id
  subnetwork_region = var.subnetwork_region != "" ? var.subnetwork_region : var.region
}

resource "google_project_iam_member" "composer_agent" {
  count   = var.grant_sa_agent_permission ? 1 : 0
  project = var.project_id
  role    = "roles/composer.ServiceAgentV2Ext"
  member  = "serviceAccount:${local.cloud_composer_sa}"
}

resource "google_composer_environment" "env" {
  provider = google-beta
  project  = var.project_id
  name     = var.name
  region   = var.region
  labels   = var.labels

  config {
    environment_size = var.environment_size
    node_config {
      network         = "projects/${local.network_project}/global/networks/${var.network}"
      subnetwork      = "projects/${local.network_project}/regions/${local.subnetwork_region}/subnetworks/${var.subnetwork}"
      service_account = var.service_account
      tags            = var.tags
    }
    software_config {
      image_version = var.image_version
      pypi_packages = var.pypi_packages
      env_variables = var.env_variables
    }
    workloads_config {
      scheduler {
        cpu        = var.scheduler.cpu
        memory_gb  = var.scheduler.memory_gb
        storage_gb = var.scheduler.storage_gb
        count      = var.scheduler.count
      }
      web_server {
        cpu        = var.web_server.cpu
        memory_gb  = var.web_server.memory_gb
        storage_gb = var.web_server.storage_gb
      }
      worker {
        cpu        = var.worker.cpu
        memory_gb  = var.worker.memory_gb
        storage_gb = var.worker.storage_gb
        min_count  = var.worker.min_count
        max_count  = var.worker.max_count
      }
    }
  }
  depends_on = [google_project_iam_member.composer_agent]
}
