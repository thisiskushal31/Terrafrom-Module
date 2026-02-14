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

### Networking (single VPC module)
| Module | Status | Description |
|--------|--------|-------------|
| **network** | Done | VPC, subnets, routes, firewall rules, and optional Private Service Access |

### Compute & databases
| Module | Status | Description |
|--------|--------|-------------|
| **compute-engine-instance** | Done | Compute Engine instance (single VM) |
| **cloud-sql-mysql** | Done | Cloud SQL for MySQL |
| **cloud-nat** | Done | Cloud NAT and optional Cloud Router |

### Storage & data
| Module | Status | Description |
|--------|--------|-------------|
| **cloud-storage** | Done | Cloud Storage (GCS) buckets |
| **bigquery** | Done | BigQuery dataset, tables, views |
| **pubsub** | Done | Pub/Sub topic and subscriptions |

### Planned GCP
- project-factory, kubernetes-engine (GKE), lb-http, cloud-dns, bootstrap, kms, secret-manager, log-export, etc.

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
