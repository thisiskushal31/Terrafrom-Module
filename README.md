# Terraform Module Bank

![Banner](./readme-assets/banner.png)

Repository of **standalone** Terraform modules by cloud or organization. Each module owns a single domain (e.g. one cloud’s product); no cross-module resource creation. Dependencies are composed by the caller.

## What’s in this repo

| Folder | Contents |
|--------|----------|
| **[gcp/](gcp/README.md)** | Google Cloud — VPC, Compute, Storage, Data, IAM, GKE, Cloud Run, Dataflow, Composer, Vertex AI, and more. See [gcp/README.md](gcp/README.md) for the full module list and usage. |
| **[aws/](aws/README.md)** | Amazon Web Services — VPC, EKS, S3, EC2, RDS, Lambda, IAM, and more. What each module is for and cross-cloud counterparts in [aws/README.md](aws/README.md). |
| **[azure/](azure/README.md)** | Microsoft Azure — AKS (cluster + node pools). See [azure/README.md](azure/README.md). *(More Azure modules to be added.)* |
| **red-hat/** | Red Hat *(planned)* |
| **oracle/** | Oracle Cloud *(planned)* |
| **others** | Additional clouds or vendors as added |

Details, module tables, and examples live in each folder’s **README.md** (e.g. [gcp/README.md](gcp/README.md) for GCP).

## Cross-cloud counterparts

Which service in one cloud corresponds to which in another. Use this to find the right module when moving or comparing across GCP, AWS, and Azure.

| Area | GCP | AWS | Azure |
|------|-----|-----|--------|
| **Networking** | network, cloud-nat | vpc | *TBD* |
| **Managed Kubernetes** | kubernetes-engine | eks | aks |
| **Compute (VM)** | compute-engine-instance | ec2-instance | *TBD* |
| **Relational DB** | cloud-sql-mysql | rds | *TBD* |
| **Object storage** | cloud-storage | s3-bucket | *TBD* |
| **Load balancing** | lb-http | alb | *TBD* |
| **DNS** | cloud-dns | route53 | *TBD* |
| **KMS / keys** | kms | kms | *TBD* |
| **Secrets** | secret-manager | secrets-manager | *TBD* |
| **Serverless function** | cloud-function | lambda | *TBD* |
| **Container registry** | artifact-registry | ecr | *TBD* |
| **Messaging** | pubsub | sns, sqs | *TBD* |
| **NoSQL / store** | cloud-datastore | dynamodb-table | *TBD* |
| **Logging** | log-export | cloudwatch | *TBD* |
| **Scheduling / events** | cloud-scheduler | eventbridge | *TBD* |
| **IAM / identity** | iam, service-accounts | iam | *TBD* |
| **Big data / Spark** | dataproc | emr | *TBD* |
| **AI / ML** | vertex-ai | sagemaker | *TBD* |

Azure column will be filled as modules are added. Per-cloud module lists and "what it's for" are in each cloud's **README** (e.g. [aws/README.md](aws/README.md), [gcp/README.md](gcp/README.md), [azure/README.md](azure/README.md)).

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
