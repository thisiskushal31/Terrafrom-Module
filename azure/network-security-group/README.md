# network-security-group

Creates an Azure Network Security Group with inbound and outbound rules. Use for VMs, AKS subnets, load balancers. Resource group from caller.

## Inputs

| Name | Description |
|------|-------------|
| name, resource_group_name, location | Required |
| inbound_rules | List of { name, priority, protocol, source/dest port, source/dest prefix } |
| outbound_rules | Same shape |
| tags | Tags |

## Outputs

- **id**, **name**
