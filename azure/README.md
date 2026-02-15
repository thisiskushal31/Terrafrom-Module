# Azure modules

Standalone Terraform modules for **Microsoft Azure**. Each module has one domain. Dependencies (VNet, resource group, IAM) are wired by the caller. No `module { source = "..." }` inside modules.

**Terraform version:** Modules are version-agnostic. Your root config sets Terraform and provider versions.

## Usage

Reference by path (local or Git). Example — AKS with subnet from a VNet module:

```hcl
module "vnet" {
  source = "./azure/network"   # or your own vnet module
  # ...
}

module "aks" {
  source               = "./azure/aks"
  resource_group_name  = "my-rg"
  location             = "eastus"
  cluster_name         = "my-aks"
  vnet_subnet_id       = module.vnet.subnet_id
  default_node_pool = {
    vm_size   = "Standard_D4s_v5"
    min_count = 1
    max_count = 10
  }
}
```

## Modules

| Module | Description |
|--------|-------------|
| **aks** | AKS cluster, default node pool, optional additional node pools; maintenance window and auto-upgrade |

Each module has `versions.tf`, `main.tf`, `variables.tf`, `outputs.tf`, and `README.md` in its folder.
