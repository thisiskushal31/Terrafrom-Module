# GCP modules

Standalone Terraform modules for **Google Cloud**. Each module has one domain (e.g. bucket in **cloud-storage**, KMS in **kms**). Dependencies are wired by the caller. No `module { source = "..." }` inside modules.

**Terraform version:** Modules are version-agnostic. Your root config sets Terraform and provider versions. For a single version everywhere, use the root `versions.tf` in the directory where you run Terraform.

## Usage

Reference by path (local or Git). Example — network and a VM:

```hcl
module "network" {
  source       = "./gcp/network"
  project_id   = var.project_id
  network_name = "my-vpc"
  subnets      = [
    { subnet_name = "subnet-01", subnet_ip = "10.10.10.0/24", subnet_region = "us-central1" },
  ]
  enable_private_service_access = true
}

module "vm" {
  source                 = "./gcp/compute-engine-instance"
  project_id             = var.project_id
  instance_name          = "my-vm"
  zone                   = "us-central1-a"
  subnetwork             = module.network.subnet_self_links["subnet-01"]
  service_account_email  = "my-sa@my-project.iam.gserviceaccount.com"
}
```

## Modules

| Module | Description |
|--------|-------------|
| **network** | VPC, subnets, routes, firewall (ingress/egress), VPC peering, Private Service Access |
| **kubernetes-engine** | GKE cluster and node pools |
| **compute-engine-instance** | Compute Engine instance (single VM) |
| **cloud-sql-mysql** | Cloud SQL for MySQL |
| **cloud-storage** | Cloud Storage (GCS) buckets |
| **resource-manager-folders** | Cloud Resource Manager folders and IAM |
| **bigquery** | BigQuery dataset, tables, views |
| **pubsub** | Pub/Sub topic and subscriptions |
| **cloud-nat** | Cloud NAT (optional Cloud Router) |
| **lb-http** | Global HTTP(S) load balancer |
| **cloud-dns** | Cloud DNS managed zone + record sets |
| **kms** | Cloud KMS key ring + keys + IAM |
| **vault** | IAM for Vault (SA access to bucket + KMS key; use with cloud-storage, kms, service-accounts) |
| **secret-manager** | Secret Manager secrets |
| **log-export** | Log sink (project/folder/org/billing) |
| **org-policy** | Organization policy (boolean or list) at project/folder/org |
| **cloud-datastore** | Cloud Datastore indexes |
| **data-fusion** | Cloud Data Fusion instance |
| **cloud-function** | Cloud Function (event or HTTP, Gen 1); bucket from cloud-storage |
| **dataflow** | Dataflow job (Flex or classic template) |
| **artifact-registry** | Artifact Registry repository (Docker, Maven, etc.) |
| **cloud-run** | Cloud Run service (Gen 2) |
| **cloud-scheduler** | Cloud Scheduler job (HTTP or Pub/Sub) |
| **composer** | Cloud Composer 2 (managed Airflow) |
| **dataproc** | Dataproc cluster (Spark/Hadoop) |
| **vertex-ai** | Vertex AI dataset and/or endpoint |
| **group** | Cloud Identity Group and optional owners, managers, members |
| **iam** | Project IAM bindings |
| **service-accounts** | Service accounts and project roles |

Each module has `versions.tf`, `main.tf`, `variables.tf`, `outputs.tf`, and `README.md` in its folder.
