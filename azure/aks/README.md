# Azure AKS (Kubernetes) Module

Creates an **Azure Kubernetes Service (AKS)** cluster with a default node pool and optional additional node pools. Network (VNet/subnet) is provided by the caller; this module only creates AKS resources.

## Scope

- `azurerm_kubernetes_cluster` with configurable default node pool
- Optional `azurerm_kubernetes_cluster_node_pool` for extra pools
- Maintenance window and automatic channel upgrade
- No VNet, subnets, or IAM outside AKS (use azure/network and Azure RBAC separately)

## Usage

```hcl
module "aks" {
  source = "./azure/aks"

  resource_group_name = "my-rg"
  location            = "eastus"
  cluster_name        = "my-aks"
  vnet_subnet_id      = module.vnet.subnet_id  # from your azure/network or vnet module

  default_node_pool = {
    vm_size        = "Standard_D4s_v5"
    min_count      = 1
    max_count      = 10
    os_disk_size_gb = 100
    os_disk_type   = "Managed"
    priority       = "Regular"  # or "Spot"
  }

  maintenance_window = {
    day            = "Monday"
    start_hour     = 2
    duration_hours = 6
  }
  auto_upgrade_channel = "patch"  # patch | rapid | stable | node_image | null

  additional_node_pools = {
    spot = {
      vm_size         = "Standard_D4s_v5"
      min_count       = 0
      max_count       = 5
      os_disk_size_gb  = 100
      priority        = "Spot"
    }
  }

  tags = { env = "prod" }
}
```

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| resource_group_name | Azure resource group name | `string` | required |
| location | Azure region | `string` | required |
| cluster_name | AKS cluster name | `string` | required |
| kubernetes_version | Kubernetes version (e.g. 1.28); omit for latest | `string` | `null` |
| vnet_subnet_id | Subnet ID for nodes (from caller) | `string` | required |
| default_node_pool | Default node pool config (vm_size, min/max count, disk, priority) | `object` | required |
| maintenance_window | Day, start_hour (0–23), duration_hours | `object` | `null` |
| auto_upgrade_channel | patch, rapid, stable, node_image, or null | `string` | `null` |
| additional_node_pools | Map of name → node pool config | `map(object)` | `{}` |
| enable_azure_policy | Enable Azure Policy add-on | `bool` | `false` |
| enable_http_application_routing | Enable HTTP application routing | `bool` | `false` |
| network_plugin | azure, kubenet, or none | `string` | `"azure"` |
| network_policy | azure or calico (when plugin = azure) | `string` | `null` |
| tags | Tags for cluster and node pools | `map(string)` | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| cluster_id | AKS cluster ID |
| cluster_name | Cluster name |
| cluster_fqdn | API server FQDN |
| kube_config_raw | Raw kubeconfig (sensitive) |
| node_resource_group | Node resource group name |
| oidc_issuer_url | OIDC issuer for workload identity |
| azure_cloud | Map with resource_group_name, cluster_name, location, kubernetes_cluster_id |

## Requirements

- Terraform >= 0.13
- Provider: `hashicorp/azurerm`
