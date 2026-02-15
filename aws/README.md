# AWS modules

Standalone Terraform modules for **Amazon Web Services**. Each module has one domain. Dependencies (VPC, IAM, etc.) are wired by the caller. No `module { source = "..." }` inside modules.

**Terraform version:** Modules are version-agnostic. Your root config sets Terraform and provider versions.

## Usage

Reference by path (local or Git). Example — EKS with subnets from a VPC module:

```hcl
module "vpc" {
  source     = "./aws/network"
  # ...
}

module "eks" {
  source       = "./aws/eks"
  cluster_name = "my-eks"
  subnet_ids   = module.vpc.private_subnet_ids
  node_groups = {
    default = {
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 10
      desired_size   = 2
    }
  }
}
```

## Modules

| Module | Description |
|--------|-------------|
| **eks** | EKS cluster, managed node groups, addons; cluster and node IAM roles |

Each module has `versions.tf`, `main.tf`, `variables.tf`, `outputs.tf`, and `README.md` in its folder.
