# Azure modules

Standalone Terraform modules for **Microsoft Azure**. Each module manages one Azure product or service (e.g. one VNet, one AKS cluster, one storage account). You supply dependencies (resource group, VNet, subnets, etc.) from your root or other modules; nothing inside these modules calls another module.

**Terraform:** Set required_version and providers in your root; these modules do not pin versions.

---

## What's here (what each module does)

| Module | What it is | What it's for |
|--------|------------|----------------|
| **aks** | AKS cluster with default and optional node pools; maintenance window and auto-upgrade | Managed Kubernetes |
| **network** | Virtual network and subnets | Base networking for AKS, VMs, load balancer, PostgreSQL |
| **network-security-group** | NSG with configurable inbound and outbound rules | Firewall for subnets and NICs |
| **virtual-machine** | Linux or Windows VM with a single NIC | VMs, bastions |
| **load-balancer** | Azure Load Balancer with backend pool, optional health probe, and rules | Load balancing for VMs or AKS |
| **postgresql** | PostgreSQL Flexible Server and optional databases | Managed relational DB |
| **storage-account** | Storage account and optional blob containers | Object storage (blobs) |

Each module has `versions.tf`, `main.tf`, `variables.tf`, `outputs.tf`, and a per-module `README.md`. No internal `module { source = "..." }` calls.

---

## How to use these modules

- **Networking:** Create a **resource group** in your root (e.g. `azurerm_resource_group`). Create **network** (VNet + subnets); pass `subnet_id` or `subnet_ids` to **aks**, **virtual-machine**, **load-balancer**, or **postgresql** (for delegated subnet).
- **Containers:** **aks** for Kubernetes; **load-balancer** in front of AKS or VMs as needed.
- **Compute:** **virtual-machine** for VMs; attach **network-security-group** to subnet or NIC.
- **Data:** **storage-account** for blobs; **postgresql** for relational DB.

Cross-cloud mapping: [main README](../README.md#cross-cloud-counterparts).

---

## Usage example

```hcl
# Create resource group in your root (e.g. azurerm_resource_group.this)

module "vnet" {
  source              = "./azure/network"
  vnet_name           = "my-vnet"
  resource_group_name = "my-rg"
  location            = "eastus"
  address_space       = ["10.0.0.0/16"]
  subnets = {
    aks = { address_prefix = "10.0.1.0/24" }
  }
}

module "aks" {
  source              = "./azure/aks"
  resource_group_name = "my-rg"
  location            = "eastus"
  cluster_name        = "my-aks"
  vnet_subnet_id      = module.vnet.subnet_ids["aks"]
  default_node_pool = {
    vm_size   = "Standard_D4s_v5"
    min_count = 1
    max_count = 10
  }
}
```

Resource group is not a module in this repo; create it in your root with `azurerm_resource_group`.
