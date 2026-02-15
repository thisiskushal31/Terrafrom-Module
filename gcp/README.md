# GCP modules

Standalone Terraform modules for **Google Cloud**. Each module manages one GCP product or service (e.g. one VPC, one GKE cluster, one bucket). You supply dependencies (project, network, IAM, etc.) from your root or other modules; nothing inside these modules calls another module.

**Terraform:** Set required_version and providers in your root; these modules do not pin versions.

---

## What's here (what each module does)

| Module | What it is | What it's for |
|--------|------------|----------------|
| **network** | VPC, subnets, routes, firewall (ingress/egress), VPC peering, Private Service Access | Base networking for GKE, VMs, Cloud SQL, etc. |
| **kubernetes-engine** | GKE cluster and node pools; Workload Identity, maintenance window | Managed Kubernetes |
| **compute-engine-instance** | Single Compute Engine VM | VMs, bastions, single-node apps |
| **cloud-sql-mysql** | Cloud SQL for MySQL | Managed relational DB |
| **cloud-storage** | Cloud Storage (GCS) buckets | Object storage, static assets, data lakes |
| **resource-manager-folders** | Resource Manager folders and IAM | Org/folder structure and policies |
| **bigquery** | BigQuery dataset, tables, views | Data warehouse and analytics |
| **pubsub** | Pub/Sub topic and subscriptions | Messaging, event-driven pipelines |
| **cloud-nat** | Cloud NAT (optional Cloud Router) | Outbound NAT for private subnets |
| **lb-http** | Global HTTP(S) load balancer | HTTP(S) load balancing |
| **cloud-dns** | Cloud DNS managed zone and record sets | DNS for public/private zones |
| **kms** | Cloud KMS key ring, keys, and IAM | Encryption keys for GCS, Secret Manager, etc. |
| **vault** | IAM for Vault (SA access to bucket and KMS) | Use with cloud-storage, kms, service-accounts |
| **secret-manager** | Secret Manager secrets | App secrets, DB credentials, API keys |
| **log-export** | Log sink (project/folder/org/billing) | Centralized logging and export |
| **org-policy** | Organization policy (boolean or list) at project/folder/org | Guardrails and constraints |
| **cloud-datastore** | Cloud Datastore indexes | NoSQL document store |
| **data-fusion** | Cloud Data Fusion instance | ETL and data integration |
| **cloud-function** | Cloud Function (event or HTTP, Gen 1) | Serverless functions |
| **dataflow** | Dataflow job (Flex or classic template) | Stream and batch data processing |
| **artifact-registry** | Artifact Registry repository (Docker, Maven, etc.) | Container and package registry |
| **cloud-run** | Cloud Run service (Gen 2) | Serverless containers |
| **cloud-scheduler** | Cloud Scheduler job (HTTP or Pub/Sub) | Scheduled invocations |
| **composer** | Cloud Composer 2 (managed Airflow) | Workflow orchestration |
| **dataproc** | Dataproc cluster (Spark/Hadoop) | Big data / Spark on GCP |
| **vertex-ai** | Vertex AI dataset and/or endpoint | ML training and inference |
| **group** | Cloud Identity Group (owners, managers, members) | Identity and access |
| **iam** | Project IAM bindings | Roles and permissions at project level |
| **service-accounts** | Service accounts and project roles | Workload identity |

Each module has `versions.tf`, `main.tf`, `variables.tf`, `outputs.tf`, and a per-module `README.md`. No internal `module { source = "..." }` calls.

---

## How to use these modules

- **Networking:** Create **network** first; use **cloud-nat** if you need outbound NAT for private subnets. Pass subnet/network outputs to **kubernetes-engine**, **compute-engine-instance**, **cloud-sql-mysql**, etc.
- **Containers:** **artifact-registry** for images; **kubernetes-engine** for GKE or **cloud-run** for serverless containers; **lb-http** in front as needed.
- **Apps and APIs:** **cloud-function** or **cloud-run** for serverless; **compute-engine-instance** for VMs; **cloud-sql-mysql** for DB; **secret-manager** for config.
- **Data and events:** **cloud-storage**, **bigquery**, **pubsub**, **dataflow**, **dataproc**, **composer**, **cloud-datastore**.
- **Identity and security:** **iam**, **service-accounts**, **kms**, **cloud-dns**; **org-policy** and **resource-manager-folders** for governance.

Cross-cloud mapping: [main README](../README.md#cross-cloud-counterparts).

---

## Usage example

```hcl
module "network" {
  source       = "./gcp/network"
  project_id   = var.project_id
  network_name = "my-vpc"
  subnets = [
    { subnet_name = "subnet-01", subnet_ip = "10.10.10.0/24", subnet_region = "us-central1" },
  ]
  enable_private_service_access = true
}

module "vm" {
  source                = "./gcp/compute-engine-instance"
  project_id            = var.project_id
  instance_name         = "my-vm"
  zone                  = "us-central1-a"
  subnetwork            = module.network.subnet_self_links["subnet-01"]
  service_account_email = "my-sa@my-project.iam.gserviceaccount.com"
}
```
