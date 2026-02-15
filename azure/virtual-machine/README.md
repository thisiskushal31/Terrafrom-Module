# virtual-machine

Creates an Azure Linux or Windows VM with a single NIC. Subnet and resource group from caller. Use for VMs, bastions.

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| vm_name, resource_group_name, location | Required | — |
| subnet_id | From network module | required |
| vm_size | e.g. Standard_B2s | Standard_B2s |
| os_type | linux or windows | linux |
| admin_username, admin_ssh_public_key (Linux) or admin_password | Auth | — |
| tags | Tags | {} |

## Outputs

- **vm_id**, **private_ip_address**, **network_interface_id**
