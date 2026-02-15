# Module roadmap — GCP, AWS, Azure

Every module is **standalone**: only `resource "google_*"` (and similar)—no `module { source = "..." }`, no wrapper. Names follow GCP product terminology.

---

## GCP modules

### Foundation & organization
| Module | Status | Description |
|--------|--------|-------------|
| **resource-manager-folders** | Done | Cloud Resource Manager folders and IAM |
| **iam** | Done | Project IAM bindings (additive) |
| **service-accounts** | Done | Service accounts and project roles |
| **group** | Done | Cloud Identity Group and optional owners, managers, members |

### Networking (single VPC module)
| Module | Status | Description |
|--------|--------|-------------|
| **network** | Done | VPC, subnets, routes, firewall rules, and optional Private Service Access |

### Compute & databases
| Module | Status | Description |
|--------|--------|-------------|
| **compute-engine-instance** | Done | Compute Engine instance (single VM) |
| **kubernetes-engine** | Done | GKE cluster and node pools |
| **cloud-sql-mysql** | Done | Cloud SQL for MySQL |
| **cloud-nat** | Done | Cloud NAT and optional Cloud Router |

### Storage & data
| Module | Status | Description |
|--------|--------|-------------|
| **cloud-storage** | Done | Cloud Storage (GCS) buckets |
| **bigquery** | Done | BigQuery dataset, tables, views |
| **pubsub** | Done | Pub/Sub topic and subscriptions |
| **cloud-datastore** | Done | Cloud Datastore indexes |
| **data-fusion** | Done | Cloud Data Fusion instance |
| **cloud-function** | Done | Cloud Function (event or HTTP trigger, Gen 1) |
| **dataflow** | Done | Dataflow job (Flex or classic template) |
| **artifact-registry** | Done | Artifact Registry repository (Docker, Maven, etc.) |
| **cloud-run** | Done | Cloud Run service (Gen 2) |
| **cloud-scheduler** | Done | Cloud Scheduler job (HTTP or Pub/Sub) |
| **composer** | Done | Cloud Composer 2 (managed Airflow) |
| **dataproc** | Done | Dataproc cluster (Spark/Hadoop) |
| **vertex-ai** | Done | Vertex AI dataset and/or endpoint |

### Load balancing, DNS, security & observability
| Module | Status | Description |
|--------|--------|-------------|
| **lb-http** | Done | Global HTTP(S) load balancer |
| **cloud-dns** | Done | Cloud DNS managed zone (public/private) + record sets |
| **kms** | Done | Cloud KMS key ring + keys + IAM |
| **vault** | Done | GCP infrastructure for HashiCorp Vault (GCS + KMS + SA) |
| **secret-manager** | Done | Secret Manager secrets + optional version |
| **log-export** | Done | Log sink (project/folder/org/billing); SRE: centralised logging, audit |
| **org-policy** | Done | Organization policy (boolean or list) at project/folder/org |

### Orchestrator-handled (not modules here)
- **project-factory** and **bootstrap** are run by the infra orchestrator (external Terraform).

---

## AWS modules

| Module | Status | Description |
|--------|--------|-------------|
| (TBD) | Planned | VPC, EC2, RDS, S3, IAM, EKS, … |

---

## Azure modules

| Module | Status | Description |
|--------|--------|-------------|
| (TBD) | Planned | VNet, VMs, AKS, Storage, … |
