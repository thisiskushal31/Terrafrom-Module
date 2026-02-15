# Terraform Module Bank

![Banner](./readme-assets/banner.png)

Repository of **standalone** Terraform modules by cloud or organization. Each module owns a single domain (e.g. one cloud’s product); no cross-module resource creation. Dependencies are composed by the caller.

## What’s in this repo

| Folder | Contents |
|--------|----------|
| **[gcp/](gcp/README.md)** | Google Cloud — VPC, Compute, Storage, Data, IAM, GKE, Cloud Run, Dataflow, Composer, Vertex AI, and more. See [gcp/README.md](gcp/README.md) for the full module list and usage. |
| **[aws/](aws/README.md)** | Amazon Web Services — EKS (cluster + node groups). See [aws/README.md](aws/README.md). |
| **[azure/](azure/README.md)** | Microsoft Azure — AKS (cluster + node pools). See [azure/README.md](azure/README.md). |
| **red-hat/** | Red Hat *(planned)* |
| **oracle/** | Oracle Cloud *(planned)* |
| **others** | Additional clouds or vendors as added |

Details, module tables, and examples live in each folder’s **README.md** (e.g. [gcp/README.md](gcp/README.md) for GCP).

## Repo layout

```
Terrafrom-Module/
├── gcp/           # Google Cloud — see gcp/README.md
├── aws/           # AWS — EKS; see aws/README.md
├── azure/         # Azure — AKS; see azure/README.md
├── versions.tf    # Optional: use when running with one Terraform/provider version
└── README.md      # This file
```

**Terraform version:** Modules are version-agnostic. Use the root `versions.tf` in the directory where you run Terraform when you want a single version for all modules.
