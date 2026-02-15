/**
 * Standalone module: Compute Engine instance (single VM).
 * GCP product: Compute Engine → VM instance. Only google_compute_instance and google_compute_disk—no module calls.
 * For managed instance groups use an instance template + MIG instead.
 */

locals {
  ssh_metadata     = var.ssh_keys != null && var.ssh_keys != "" ? { "ssh-keys" = var.ssh_keys } : {}
  startup_metadata = var.startup_script != null && var.startup_script != "" ? { "startup-script" = var.startup_script } : (var.startup_script_url != null && var.startup_script_url != "" ? { "startup-script-url" = var.startup_script_url } : {})
  metadata_map     = merge(var.metadata, local.ssh_metadata, local.startup_metadata)
}

resource "google_compute_instance" "vm" {
  name         = var.instance_name
  project      = var.project_id
  zone         = var.zone
  machine_type = var.machine_type
  tags         = var.network_tags
  labels       = var.labels

  boot_disk {
    initialize_params {
      image = var.gcp_image != "" ? var.gcp_image : "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = var.boot_disk_size_gb
      type  = var.boot_disk_type
    }
  }

  dynamic "scratch_disk" {
    for_each = var.attach_local_ssd ? [1] : []
    content {
      interface = "NVME"
    }
  }

  dynamic "attached_disk" {
    for_each = var.enable_additional_disk ? [1] : []
    content {
      source      = google_compute_disk.additional[0].self_link
      device_name = "data"
    }
  }

  network_interface {
    subnetwork         = var.subnetwork
    subnetwork_project = var.subnetwork_project != null ? var.subnetwork_project : var.project_id

    dynamic "access_config" {
      for_each = var.assign_public_ip ? [1] : []
      content {}
    }
  }

  metadata = length(local.metadata_map) > 0 ? local.metadata_map : null

  service_account {
    email  = var.service_account_email
    scopes = var.service_account_scopes
  }

  scheduling {
    preemptible                 = var.preemptible
    automatic_restart           = var.preemptible ? false : var.automatic_restart
    on_host_maintenance         = var.preemptible ? "TERMINATE" : var.on_host_maintenance
    provisioning_model          = var.spot ? "SPOT" : null
    instance_termination_action = var.spot ? "STOP" : null
  }

  allow_stopping_for_update = var.allow_stopping_for_update

  lifecycle {
    ignore_changes = [
      metadata["ssh-keys"],
    ]
  }
}

resource "google_compute_disk" "additional" {
  count   = var.enable_additional_disk ? 1 : 0
  name    = "${var.instance_name}-data"
  project = var.project_id
  zone    = var.zone
  size    = var.additional_disk_size_gb
  type    = var.additional_disk_type
}
