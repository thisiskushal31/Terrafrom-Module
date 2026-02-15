# load-balancer

Creates an Azure Load Balancer (Standard) with backend pool, optional health probe, and LB rules. Use public_ip_address_id for public LB or subnet_id for internal. Attach VMs to backend_pool_id via azurerm_network_interface_backend_address_pool_association.

## Inputs

| Name | Description |
|------|-------------|
| name, resource_group_name, location | Required |
| public_ip_address_id | For public LB |
| subnet_id, private_ip_address | For internal LB |
| lb_rules | Map of rule name to { protocol, frontend_port, backend_port } |
| probe_port | Optional health probe |
| tags | Tags |

## Outputs

- **lb_id**, **backend_pool_id**, **frontend_private_ip**
