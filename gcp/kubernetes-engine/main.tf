/**
 * GKE cluster and multiple node pools. Network from gcp/network; IAM managed via gcp/iam using per-pool service_account.
 */

locals {
  maintenance_days = [for d in var.maintenance_days : upper(trimspace(d))]
  day_to_byday     = { "SUNDAY" = "SU", "MONDAY" = "MO", "TUESDAY" = "TU", "WEDNESDAY" = "WE", "THURSDAY" = "TH", "FRIDAY" = "FR", "SATURDAY" = "SA" }
  byday            = length(local.maintenance_days) > 0 ? join(",", [for d in local.maintenance_days : lookup(local.day_to_byday, d, substr(d, 0, 2))]) : "SU"
  use_recurring    = length(local.maintenance_days) > 1 || (length(local.maintenance_days) == 1 && local.maintenance_days[0] != "SUNDAY")
  maintenance_start_time = "2024-01-07T${format("%02d", var.maintenance_start_hour)}:00:00Z"
  maintenance_end_time   = "2024-01-07T${format("%02d", min(23, var.maintenance_start_hour + var.maintenance_duration_hours))}:00:00Z"
  maintenance_recurrence = "FREQ=WEEKLY;BYDAY=${local.byday}"
  subnetwork_name        = try(element(split("/", var.subnetwork_self_link), length(split("/", var.subnetwork_self_link)) - 1), "default")
  network_name           = try(element(split("/", var.network_self_link), length(split("/", var.network_self_link)) - 1), "default")
}

resource "google_container_cluster" "primary" {
  provider = google-beta

  project             = var.project_id
  name                = var.cluster_name
  description         = var.description != "" ? var.description : null
  location            = var.region
  deletion_protection = var.deletion_protection

  dynamic "release_channel" {
    for_each = var.kubernetes_version == null ? [1] : []
    content {
      channel = var.release_channel
    }
  }
  min_master_version = var.kubernetes_version

  network    = var.network_self_link
  subnetwork = var.subnetwork_self_link

  ip_allocation_policy {
    cluster_secondary_range_name  = var.secondary_range_pod
    services_secondary_range_name = var.secondary_range_services
    stack_type                    = var.stack_type
  }

  default_snat_status {
    disabled = var.disable_default_snat
  }

  dynamic "private_cluster_config" {
    for_each = var.enable_private_nodes ? [1] : []
    content {
      enable_private_nodes    = var.enable_private_nodes
      enable_private_endpoint = var.enable_private_endpoint
      master_ipv4_cidr_block  = var.master_ipv4_cidr_block != null ? var.master_ipv4_cidr_block : "172.16.0.0/28"
      dynamic "master_global_access_config" {
        for_each = var.master_global_access_enabled ? [1] : []
        content {
          enabled = true
        }
      }
    }
  }

  dynamic "master_authorized_networks_config" {
    for_each = var.enable_private_endpoint || var.gcp_public_cidrs_access_enabled != null || length(var.master_authorized_networks) > 0 ? [1] : []
    content {
      gcp_public_cidrs_access_enabled = var.gcp_public_cidrs_access_enabled
      dynamic "cidr_blocks" {
        for_each = var.master_authorized_networks
        content {
          cidr_block   = cidr_blocks.value
          display_name = "block-${cidr_blocks.key}"
        }
      }
    }
  }

  maintenance_policy {
    dynamic "recurring_window" {
      for_each = local.use_recurring ? [1] : []
      content {
        start_time = local.maintenance_start_time
        end_time   = local.maintenance_end_time
        recurrence = local.maintenance_recurrence
      }
    }
    dynamic "daily_maintenance_window" {
      for_each = local.use_recurring ? [] : [1]
      content {
        start_time = format("%02d:00", var.maintenance_start_hour)
      }
    }
    dynamic "maintenance_exclusion" {
      for_each = var.maintenance_exclusions
      content {
        exclusion_name = maintenance_exclusion.value.name
        start_time     = maintenance_exclusion.value.start_time
        end_time       = maintenance_exclusion.value.end_time
        dynamic "exclusion_options" {
          for_each = try(maintenance_exclusion.value.exclusion_scope, null) != null ? [maintenance_exclusion.value.exclusion_scope] : []
          content {
            scope = exclusion_options.value
          }
        }
      }
    }
  }

  dynamic "cluster_autoscaling" {
    for_each = var.enable_node_auto_provisioning ? [1] : []
    content {
      enabled = true
      resource_limits {
        resource_type = "cpu"
        minimum       = var.node_auto_provisioning_cpu_min
        maximum       = var.node_auto_provisioning_cpu_max
      }
      resource_limits {
        resource_type = "memory"
        minimum       = var.node_auto_provisioning_memory_min
        maximum       = var.node_auto_provisioning_memory_max
      }
    }
  }

  dynamic "network_policy" {
    for_each = var.network_policy ? [1] : []
    content {
      enabled  = true
      provider = var.network_policy_provider
    }
  }

  addons_config {
    http_load_balancing {
      disabled = !var.http_load_balancing
    }
    horizontal_pod_autoscaling {
      disabled = !var.horizontal_pod_autoscaling
    }
    network_policy_config {
      disabled = !var.network_policy
    }
    dns_cache_config {
      enabled = var.dns_cache
    }
    gcp_filestore_csi_driver_config {
      enabled = var.filestore_csi_driver
    }
    gce_persistent_disk_csi_driver_config {
      enabled = var.gce_pd_csi_driver
    }
    gcs_fuse_csi_driver_config {
      enabled = var.gcs_fuse_csi_driver
    }
    config_connector_config {
      enabled = var.config_connector
    }
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = var.issue_client_certificate
    }
  }

  dynamic "binary_authorization" {
    for_each = var.enable_binary_authorization ? [1] : []
    content {
      evaluation_mode = "PROJECT_SINGLETON_POLICY_ENFORCE"
    }
  }

  dynamic "database_encryption" {
    for_each = var.database_encryption
    content {
      state    = database_encryption.value.state
      key_name = database_encryption.value.key_name
    }
  }

  security_posture_config {
    mode               = var.security_posture_mode
    vulnerability_mode = var.security_posture_vulnerability_mode
  }

  dynamic "workload_identity_config" {
    for_each = var.workload_identity_config != null && var.workload_identity_config != "" ? [1] : []
    content {
      workload_pool = var.workload_identity_config
    }
  }

  dynamic "identity_service_config" {
    for_each = var.enable_identity_service != null ? [1] : []
    content {
      enabled = var.enable_identity_service
    }
  }

  dynamic "dns_config" {
    for_each = var.cluster_dns != "PROVIDER_UNSPECIFIED" || var.cluster_dns_scope != "DNS_SCOPE_UNSPECIFIED" || var.cluster_dns_domain != "" ? [1] : []
    content {
      cluster_dns        = var.cluster_dns
      cluster_dns_scope  = var.cluster_dns_scope
      cluster_dns_domain = var.cluster_dns_domain
    }
  }

  dynamic "monitoring_config" {
    for_each = length(var.monitoring_enabled_components) > 0 || var.enable_managed_prometheus ? [1] : []
    content {
      enable_components = length(var.monitoring_enabled_components) > 0 ? var.monitoring_enabled_components : ["SYSTEM_COMPONENTS"]
      managed_prometheus {
        enabled = var.enable_managed_prometheus
      }
    }
  }

  notification_config {
    pubsub {
      enabled = var.notification_config_topic != "" ? true : false
      topic   = var.notification_config_topic
      dynamic "filter" {
        for_each = length(var.notification_config_event_types) > 0 ? [1] : []
        content {
          event_type = var.notification_config_event_types
        }
      }
    }
  }

  dynamic "secret_manager_config" {
    for_each = var.enable_secret_manager_addon ? [1] : []
    content {
      enabled = true
    }
  }

  datapath_provider = var.datapath_provider

  dynamic "service_external_ips_config" {
    for_each = var.service_external_ips ? [1] : []
    content {
      enabled = true
    }
  }

  enable_intranode_visibility = var.enable_intranode_visibility

  enable_fqdn_network_policy = var.enable_fqdn_network_policy

  dynamic "gateway_api_config" {
    for_each = var.gateway_api_channel != null ? [1] : []
    content {
      channel = var.gateway_api_channel
    }
  }

  logging_config {
    enable_components = var.enable_workload_logging ? ["SYSTEM_COMPONENTS", "WORKLOADS"] : ["SYSTEM_COMPONENTS"]
  }

  dynamic "vertical_pod_autoscaling" {
    for_each = var.enable_vertical_pod_autoscaling ? [1] : []
    content {
      enabled = true
    }
  }

  default_max_pods_per_node = var.default_max_pods_per_node
  enable_shielded_nodes     = var.enable_shielded_nodes

  remove_default_node_pool = true
  initial_node_count      = 1

  resource_labels = var.labels

  lifecycle {
    ignore_changes = [
      initial_node_count,
      node_config,
    ]
  }
}

resource "google_container_node_pool" "pool" {
  for_each = var.node_pools

  provider = google-beta

  project           = var.project_id
  name              = each.key
  location          = var.region
  cluster           = google_container_cluster.primary.name
  node_locations    = length(each.value.zones) > 0 ? each.value.zones : null
  max_pods_per_node = each.value.max_pods_per_node

  node_count = 0
  autoscaling {
    min_node_count = each.value.min_nodes
    max_node_count = each.value.max_nodes
  }

  management {
    auto_repair  = each.value.auto_repair
    auto_upgrade = each.value.auto_upgrade
  }

  dynamic "upgrade_settings" {
    for_each = [1]
    content {
      max_surge       = each.value.max_surge
      max_unavailable = each.value.max_unavailable
    }
  }

  node_config {
    machine_type    = each.value.machine_type
    disk_size_gb    = each.value.disk_size_gb
    disk_type       = each.value.disk_type
    image_type      = each.value.image_type
    min_cpu_platform = each.value.min_cpu_platform
    service_account = each.value.service_account
    labels          = each.value.labels
    tags            = length(each.value.tags) > 0 ? each.value.tags : null

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }

    dynamic "taint" {
      for_each = each.value.taints
      content {
        key    = taint.value.key
        value  = taint.value.value
        effect = taint.value.effect
      }
    }

    dynamic "shielded_instance_config" {
      for_each = each.value.enable_secure_boot ? [1] : []
      content {
        enable_secure_boot = true
      }
    }

    dynamic "guest_accelerator" {
      for_each = each.value.guest_accelerator != null ? [each.value.guest_accelerator] : []
      content {
        type  = guest_accelerator.value.type
        count = guest_accelerator.value.count
      }
    }

    spot = each.value.node_lifecycle == "SPOT"
  }

  lifecycle {
    ignore_changes = [node_count]
  }
}
