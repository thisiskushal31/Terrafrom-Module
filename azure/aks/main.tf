/**
 * AKS cluster with default node pool and optional additional node pools.
 * VNet/subnet provided by caller; this module only creates AKS resources.
 */

locals {
  # Maintenance window for auto-upgrade (Weekly, day + start time + duration in hours)
  use_maintenance = var.maintenance_window != null
  maintenance_start_time = local.use_maintenance ? format("%02d:00", var.maintenance_window.start_hour) : null
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  kubernetes_version  = var.kubernetes_version
  node_resource_group = "${var.resource_group_name}-aks-nodes"
  dns_prefix          = var.cluster_name

  default_node_pool {
    name                = "default"
    vm_size             = var.default_node_pool.vm_size
    vnet_subnet_id      = var.vnet_subnet_id
    enable_auto_scaling = true
    min_count           = var.default_node_pool.min_count
    max_count           = var.default_node_pool.max_count
    os_disk_size_gb     = var.default_node_pool.os_disk_size_gb
    os_disk_type        = var.default_node_pool.os_disk_type
    priority            = var.default_node_pool.priority
    node_labels         = var.default_node_pool.node_labels
    node_taints         = length(var.default_node_pool.node_taints) > 0 ? var.default_node_pool.node_taints : null
  }

  dynamic "maintenance_window" {
    for_each = local.use_maintenance ? [1] : []
    content {
      maintenance_window_auto_upgrade {
        frequency   = "Weekly"
        interval    = 1
        day_of_week = var.maintenance_window.day
        start_time  = local.maintenance_start_time
        duration    = var.maintenance_window.duration_hours
      }
    }
  }

  automatic_channel_upgrade = var.auto_upgrade_channel

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = var.network_plugin
    network_policy     = var.network_policy
    load_balancer_sku  = "standard"
  }

  azure_policy_enabled                    = var.enable_azure_policy
  http_application_routing_enabled         = var.enable_http_application_routing

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "extra" {
  for_each = var.additional_node_pools

  name                  = each.key
  kubernetes_cluster_id  = azurerm_kubernetes_cluster.cluster.id
  vm_size               = each.value.vm_size
  vnet_subnet_id        = var.vnet_subnet_id
  enable_auto_scaling   = true
  min_count             = each.value.min_count
  max_count             = each.value.max_count
  os_disk_size_gb       = each.value.os_disk_size_gb
  os_disk_type         = each.value.os_disk_type
  priority              = each.value.priority
  node_labels           = each.value.node_labels
  node_taints           = length(each.value.node_taints) > 0 ? each.value.node_taints : null
  max_pods              = each.value.max_pods

  tags = var.tags
}
