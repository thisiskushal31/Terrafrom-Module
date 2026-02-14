# Module roadmap — GCP, AWS, Azure

Every module is **standalone**: only `resource "google_*"` (and similar)—no `module { source = "..." }`, no wrapper. Names follow GCP product terminology.

**Alignment with modules-clone and foundation:** See [MODULES_CLONE_ALIGNMENT.md](./MODULES_CLONE_ALIGNMENT.md) for how this repo maps to **modules-clone** (excluding Facets), **cloud-foundation-training**, and **terraform-example-foundation**, and for full GCP module exposure.

---

## GCP modules

### Foundation & organization
| Module | Status | Description |
|--------|--------|-------------|
| **resource-manager-folders** | Done | Cloud Resource Manager folders and IAM |
| **iam** | Done | Project IAM bindings (additive) |
| **service-accounts** | Done | Service accounts and project roles |

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

### Load balancing, DNS, security & observability
| Module | Status | Description |
|--------|--------|-------------|
| **lb-http** | Done | Global HTTP(S) load balancer |
| **cloud-dns** | Done | Cloud DNS managed zone (public/private) + record sets |
| **kms** | Done | Cloud KMS key ring + keys + IAM |
| **secret-manager** | Done | Secret Manager secrets + optional version |
| **log-export** | Done | Log sink (project/folder/org/billing); SRE: centralised logging, audit |

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
