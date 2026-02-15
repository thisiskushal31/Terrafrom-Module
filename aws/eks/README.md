# AWS EKS Module

Creates an **Amazon EKS** cluster with optional managed node groups and addons. VPC/subnets are provided by the caller; this module creates cluster and node IAM roles and EKS resources only.

## Scope

- `aws_iam_role` + policy attachments for cluster and nodes
- `aws_eks_cluster` with configurable endpoint and logging
- `aws_eks_node_group` for each entry in `node_groups`
- `aws_eks_addon` for each entry in `addons`
- No VPC, subnets, or extra IAM (use aws/network and IAM modules separately)

## Usage

```hcl
module "eks" {
  source = "./aws/eks"

  cluster_name = "my-eks"
  subnet_ids   = module.vnet.private_subnet_ids  # from your aws/network or vnet module

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true
  public_access_cidrs            = ["10.0.0.0/8", "192.168.0.0/16"]
  cloudwatch_log_retention_days   = 90

  node_groups = {
    default = {
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 10
      desired_size   = 2
      disk_size      = 100
      capacity_type  = "ON_DEMAND"  # or SPOT
    }
    spot = {
      instance_types = ["t3.medium", "t3a.medium"]
      min_size       = 0
      max_size       = 5
      capacity_type  = "SPOT"
    }
  }

  addons = {
    vpc-cni    = { version = null }
    coredns    = { version = null }
    kube-proxy = { version = null }
    ebs-csi-driver = { version = null }
  }

  tags = { env = "prod" }
}
```

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| cluster_name | EKS cluster name | `string` | required |
| cluster_version | Kubernetes version (e.g. 1.28) | `string` | `null` |
| subnet_ids | Subnet IDs for cluster and node groups | `list(string)` | required |
| cluster_endpoint_public_access | Enable public API endpoint | `bool` | `true` |
| cluster_endpoint_private_access | Enable private API endpoint | `bool` | `true` |
| public_access_cidrs | CIDRs allowed to reach public endpoint | `list(string)` | `["0.0.0.0/0"]` |
| enabled_cluster_log_types | CloudWatch log types (api, audit, authenticator) | `list(string)` | see variables |
| cloudwatch_log_retention_days | Retention days for cluster logs (caller can set on log groups) | `number` | `90` |
| default_reclaim_policy | Default storage reclaim (documentation only) | `string` | `"Delete"` |
| node_groups | Map of node group name → config | `map(object)` | `{}` |
| addons | Map of addon name → { version, resolve_conflicts, preserve, configuration_values } | `map(object)` | `{}` |
| tags | Tags for cluster and node groups | `map(string)` | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| cluster_id | EKS cluster ID |
| cluster_name | Cluster name |
| cluster_arn | Cluster ARN |
| cluster_endpoint | API endpoint (sensitive) |
| cluster_certificate_authority_data | CA cert (sensitive) |
| cluster_version | Kubernetes version |
| cluster_iam_role_arn | Cluster IAM role ARN |
| node_iam_role_arn | Node IAM role ARN |
| oidc_issuer_url | OIDC issuer for IRSA |
| aws_cloud | Map with cluster_name, cluster_arn, cluster_id |

## Requirements

- Terraform >= 0.13
- Provider: `hashicorp/aws`
