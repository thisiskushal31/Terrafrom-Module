# Terraform Module Bank

![Banner](./readme-assets/banner.png)

A library of **standalone** Terraform modules by cloud. Each module manages a single product or service (e.g. one VPC, one Kubernetes cluster, one bucket). Dependencies are composed by the caller; no cross-module resource creation inside modules.

---

## What's in this repo

| Folder | What it does |
|--------|----------------|
| **[gcp/](gcp/README.md)** | **Google Cloud** — Networking (VPC, NAT), compute (VMs, GKE, Cloud Run), storage (GCS, BigQuery, Datastore), data (Dataflow, Dataproc, Composer), IAM, secrets, DNS, Vertex AI. Full module list and usage in [gcp/README.md](gcp/README.md). |
| **[aws/](aws/README.md)** | **Amazon Web Services** — Networking (VPC), compute (EC2, EKS, Lambda, ECS), storage (S3, ECR, DynamoDB), data (RDS, Redshift, EMR, MSK), messaging (SQS, SNS, EventBridge), IAM, secrets, DNS, ACM, SageMaker. Full module list and usage in [aws/README.md](aws/README.md). |
| **[azure/](azure/README.md)** | **Microsoft Azure** — Networking (VNet, NSG), compute (AKS, VMs), load balancer, storage (Storage Account), data (PostgreSQL Flexible Server). Full module list and usage in [azure/README.md](azure/README.md). |
| **red-hat/** | Red Hat *(planned)* |
| **oracle/** | Oracle Cloud *(planned)* |

Each cloud folder has a **README** with a module table (what each module is and what it’s for), how to use the modules, and an example.

---

## Cross-cloud counterparts

Use this table to see which service in one cloud matches another when moving or comparing workloads.

| Area | GCP | AWS | Azure |
|------|-----|-----|--------|
| **Networking** | network, cloud-nat | vpc | network |
| **Managed Kubernetes** | kubernetes-engine | eks | aks |
| **Compute (VM)** | compute-engine-instance | ec2-instance | virtual-machine |
| **Relational DB** | cloud-sql-mysql | rds | postgresql |
| **Object storage** | cloud-storage | s3-bucket | storage-account |
| **Load balancing** | lb-http | alb | load-balancer |
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

*TBD* = not yet implemented in this repo for that cloud.

---

## Repo layout

```
Terrafrom-Module/
├── gcp/           # Google Cloud modules — see gcp/README.md
├── aws/           # AWS modules — see aws/README.md
├── azure/         # Azure modules — see azure/README.md
├── versions.tf    # Optional: root Terraform/provider version constraints
└── README.md      # This file
```

**Terraform version:** Modules are version-agnostic. Use the root `versions.tf` where you run Terraform to pin versions if you want.
