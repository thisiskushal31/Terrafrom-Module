# Alignment with modules-clone (excluding Facets) and foundation

This repo (**Terrafrom-Module**) is your own project. The **modules-clone** directory is used only as a **reference** for behavior and features. No code is deployed from Facets, and no product names (e.g. Facets) appear in this module bank.

This document maps **modules-clone** (excluding **facets-modules**) and **foundation / examples** to what is **supported** in Terrafrom-Module and what is **planned** for full GCP coverage.

---

## What’s in modules-clone (excluding Facets)

- **terraform-google-*** — Official Google Terraform modules (e.g. terraform-google-kubernetes-engine, terraform-google-network, terraform-google-bigquery).
- **cloud-foundation-training** — Training labs (e.g. 01-Getting-Started, 02-IAM, 03-Networking, 04-Instance-Group, 05-Load-Balancer, 06-Cloud-Function).
- **terraform-example-foundation** — CFT-style foundation (0-bootstrap, 1-org, 2-environments, 3-networks-*, 4-projects, 5-app-infra).
- **terraform-example-shared-services** — Shared services examples.
- **docs-examples** / **terraform-docs-samples** — Docs and sample code.

**Excluded:** **facets-modules** (not used as a source for this module bank).

---

## Supported in this repo (examples & foundation)

Where Terrafrom-Module has a module, it is designed so that:

- **terraform-google-kubernetes-engine** — Use cases and features from the Google GKE module (including private-cluster, addons, maintenance, node pools, etc.) are supported by **gcp/kubernetes-engine**. Same GKE API surface; different variable names and structure.
- **terraform-google-network** — VPC/subnet/firewall/Private Service Access use cases are covered by **gcp/network**.
- **terraform-google-folders** — Folder hierarchy and IAM are covered by **gcp/resource-manager-folders**.
- **terraform-google-iam** / **terraform-google-service-accounts** — Project IAM and service accounts are covered by **gcp/iam** and **gcp/service-accounts**.
- **terraform-google-cloud-nat** — **gcp/cloud-nat** covers NAT and optional Cloud Router.
- **terraform-google-bigquery** / **terraform-google-pubsub** / **terraform-google-cloud-storage** — **gcp/bigquery**, **gcp/pubsub**, **gcp/cloud-storage** cover the same resource types.
- **terraform-google-sql-db** (MySQL) — **gcp/cloud-sql-mysql** covers Cloud SQL for MySQL.
- **terraform-google-vm** — **gcp/compute-engine-instance** covers single-VM use cases.

**Cloud-foundation-training** — Labs that use VPC, IAM, service accounts, instances, load balancers, Cloud Functions, etc. are supported **where a corresponding Terrafrom-Module exists** (network, iam, service-accounts, compute-engine-instance). Load balancer and Cloud Function modules are not yet in this repo (see below).

**terraform-example-foundation** — Bootstrap, org, environments, networks, projects, and app infra patterns are supported **in so far as** they rely on folders, IAM, network, and project-level resources. This repo does not include the foundation’s wrapper structure; you compose the same patterns using **gcp/resource-manager-folders**, **gcp/network**, **gcp/iam**, **gcp/service-accounts**, **gcp/kubernetes-engine**, etc.

---

## Full GCP module exposure — modules-clone vs Terrafrom-Module

| modules-clone | Terrafrom-Module | Status | What it does |
|---------------|------------------|--------|--------------|
| terraform-google-kubernetes-engine | gcp/kubernetes-engine | Done | GKE cluster + node pools + addons, auth, DNS, monitoring, maintenance |
| terraform-google-network | gcp/network | Done | VPC, subnets, firewall rules, optional Private Service Access |
| terraform-google-folders | gcp/resource-manager-folders | Done | Folder hierarchy and IAM |
| terraform-google-iam | gcp/iam | Done | Project IAM bindings (additive) |
| terraform-google-service-accounts | gcp/service-accounts | Done | Service accounts and project roles |
| terraform-google-cloud-nat | gcp/cloud-nat | Done | Cloud NAT; optional Cloud Router |
| terraform-google-bigquery | gcp/bigquery | Done | BigQuery datasets, tables, views |
| terraform-google-pubsub | gcp/pubsub | Done | Pub/Sub topics and subscriptions |
| terraform-google-cloud-storage | gcp/cloud-storage | Done | GCS buckets |
| terraform-google-sql-db | gcp/cloud-sql-mysql | Done | Cloud SQL for MySQL |
| terraform-google-vm | gcp/compute-engine-instance | Done | Single Compute Engine VM |
| terraform-google-project-factory | — | **Orchestrator** | Handled by infra orchestrator (external Terraform); not a module here |
| terraform-google-bootstrap | — | **Orchestrator** | Handled by infra orchestrator (external Terraform); not a module here |
| terraform-google-lb-http | gcp/lb-http | Done | Global HTTP(S) load balancer; backends, URL map, SSL; optional serverless NEGs |
| terraform-google-cloud-dns | gcp/cloud-dns | Done | Managed DNS zones (public, private, forwarding, etc.) and record sets |
| terraform-google-kms | gcp/kms | Done | KMS keyring + keys + IAM (owners, encrypters, decrypters) |
| terraform-google-secret | gcp/secret-manager | Done | Secret Manager (google_secret_manager_secret + versions); not the deprecated GCS secret module |
| terraform-google-log-export | gcp/log-export | Done | Log sinks at project/folder/org/billing; destination GCS, Pub/Sub, or BigQuery. **SRE:** centralised logging, audit, alerting |
| terraform-google-address | — | Optional | Reserve static IPs (regional/global); optional Cloud DNS forward/reverse records |
| terraform-google-lb | — | Optional | Regional TCP/UDP load balancer (target pool, forwarding rule) |
| terraform-google-lb-internal | — | Optional | Internal load balancer for GCE (forwarding rule, backends, health check) |
| terraform-google-cloud-router | — | Optional | Cloud Router (BGP); optionally create Cloud NAT on the router |
| terraform-google-memorystore | — | Optional | Memorystore Redis instance; submodules for Redis cluster, Memcache, Valkey |
| terraform-google-redis | — | Optional | **Deprecated** in clone: Redis Sentinel HA on GCE; use terraform-google-memorystore |
| terraform-google-airflow | — | As needed | **Stub** in clone: only creates a GCS bucket; placeholder for Airflow/Composer |
| terraform-google-cloud-datastore | — | As needed | Datastore index creation (via index.yaml / gcloud) |
| terraform-google-cloud-operations | — | As needed | Agent policy, Ops Agent policy, simple uptime check (logging/monitoring) |
| terraform-google-composer | — | As needed | Cloud Composer (managed Airflow) environment (V1/V2) |
| terraform-google-container-vm | — | As needed | **Deprecated** in clone: metadata for deploying containers on GCE VMs; use startup script or GKE |
| terraform-google-data-fusion | — | As needed | Data Fusion instances (BASIC/ENTERPRISE), VPC, Dataproc subnet |
| terraform-google-dataflow | — | As needed | Dataflow job configuration and deployment (submodules) |
| terraform-google-datalab | — | As needed | Cloud Datalab instance (explore/visualize data with Python/SQL) |
| terraform-google-endpoints-dns | — | As needed | DNS record on `.cloud.goog` for Cloud Endpoints (`NAME.endpoints.PROJECT.cloud.goog`) |
| terraform-google-event-function | — | As needed | Cloud Function triggered by events (e.g. Pub/Sub); source from local dir or Cloud Source Repos |
| terraform-google-github-actions-runners | — | As needed | Self-hosted GitHub Actions runners on GKE or MIG VMs; optional GitHub OIDC for GCP |
| terraform-google-gke-gitlab | — | As needed | GitLab on GKE (Cloud SQL Postgres, Memorystore Redis, GCS, optional runner) |
| terraform-google-group | — | As needed | Cloud Identity Groups and memberships (owners, managers, members) |
| terraform-google-jenkins | — | As needed | Jenkins on GCE (master + workers, GCS for build artifacts) |
| terraform-google-mariadb | — | As needed | **Stub** in clone: only GCS bucket; placeholder for Cloud SQL MariaDB |
| terraform-google-memcached | — | As needed | **Deprecated** in clone: Memcached on GCE; use terraform-google-memorystore memcache submodule |
| terraform-google-module-template | — | Reference only | Cookie cutter template for new CFT modules (generates GCS bucket example) |
| terraform-google-org-policy | — | As needed | Organization policies (boolean/list) at org/folder/project with exclude_folders/exclude_projects |
| terraform-google-sap | — | As needed | SAP on GCP (HANA, NW, S/4, HA submodules) |
| terraform-google-scheduled-function | — | As needed | Scheduled Cloud Function (Cloud Scheduler + Cloud Function on a cron) |
| terraform-google-startup-scripts | — | As needed | Library of bash functions for VM startup scripts (store in GCS, inject via instance metadata) |
| terraform-google-utils | — | Reference only | Region short names (e.g. us-central1 → usc1); no GCP API calls |
| terraform-google-vault | — | As needed | Vault on GCE (HA with GCS, TLS, auto-unseal with KMS, private subnet, optional bastion) |
| terraform-google-vpc-service-controls | — | As needed | VPC Service Controls + Access Context Manager (access policy, perimeters, access levels) |

**Foundation / examples:** Supported to the extent that they use the resource types above. New modules (e.g. lb-http, cloud-dns, bootstrap, kms, secret-manager, log-export) will extend support for more foundation and training scenarios.

---

## Summary

- **Facets:** Excluded; not used in this module bank.
- **terraform-google-kubernetes-engine, examples, cloud-foundation-training, terraform-example-foundation:** Supported where a matching Terrafrom-Module exists (GKE, network, IAM, folders, service-accounts, cloud-nat, bigquery, pubsub, cloud-storage, cloud-sql-mysql, compute-engine-instance).
- **Full GCP exposure:** ROADMAP.md and the table above list what’s done and what’s planned; adding project-factory, lb-http, cloud-dns, bootstrap, kms, secret-manager, and log-export will cover most common foundation and training use cases.
