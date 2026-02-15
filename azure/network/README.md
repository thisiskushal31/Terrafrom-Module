# network

Creates an Azure Virtual Network and subnets. Use as the base for AKS, VMs, load balancers, and databases. Resource group is provided by the caller.

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| vnet_name | VNet name | required |
| resource_group_name | Resource group name | required |
| location | Azure region | required |
| address_space | VNet address space(s) | required |
| subnets | Map of subnet name → { address_prefix } | {} |
| tags | Tags | {} |

## Outputs

- **vnet_id**, **vnet_name**, **subnet_ids** (map), **subnet_id** (first subnet)
