# kubernetes-engine (GKE)

Deploy a **GKE cluster** with **one or more node pools**. Use **gcp/network** for the VPC and **gcp/iam** to manage permissions for each node pool’s service account.

## Requirements

- **VPC**: Create the network and subnet with **gcp/network** (including secondary ranges for pods and services). Pass `network_self_link`, `subnetwork_self_link`, and the two secondary range names into this module.
- **Provider**: `google-beta`.

## Usage

**Single node pool:**

```hcl
module "network" {
  source       = "./gcp/network"
  project_id   = var.project_id
  network_name = "my-vpc"
  subnets = [{
    subnet_name   = "my-subnet"
    subnet_ip     = "10.0.0.0/20"
    subnet_region = var.region
  }]
  secondary_ranges = {
    "my-subnet" = [
      { range_name = "pods", ip_cidr_range = "10.1.0.0/16" },
      { range_name = "services", ip_cidr_range = "10.2.0.0/20" }
    ]
  }
}

module "gke" {
  source                  = "./gcp/kubernetes-engine"
  project_id               = var.project_id
  region                   = var.region
  cluster_name             = "my-cluster"
  network_self_link        = module.network.network_self_link
  subnetwork_self_link     = module.network.subnet_self_links["my-subnet"]
  secondary_range_pod      = "pods"
  secondary_range_services = "services"

  node_pools = {
    default = {
      machine_type = "e2-standard-4"
      min_nodes    = 0
      max_nodes    = 5
    }
  }
}
```

**Multiple node pools (e.g. default + GPU or high-mem):**

```hcl
module "gke" {
  source                  = "./gcp/kubernetes-engine"
  project_id               = var.project_id
  region                   = var.region
  cluster_name             = "my-cluster"
  network_self_link        = module.network.network_self_link
  subnetwork_self_link     = module.network.subnet_self_links["my-subnet"]
  secondary_range_pod      = "pods"
  secondary_range_services = "services"

  node_pools = {
    default = {
      machine_type = "e2-standard-4"
      min_nodes    = 0
      max_nodes    = 5
    }
    highmem = {
      machine_type = "n2-highmem-4"
      disk_size_gb = 100
      min_nodes    = 0
      max_nodes    = 3
      zones        = ["us-central1-a", "us-central1-b"]
    }
  }
}
```

**Per-pool service account (manage IAM via gcp/iam):**

```hcl
module "gke_sa" {
  source       = "./gcp/service-accounts"
  project_id   = var.project_id
  names        = ["gke-default", "gke-highmem"]
  display_name = "GKE node pool"
}

module "gke" {
  source                  = "./gcp/kubernetes-engine"
  # ... network ...

  node_pools = {
    default = {
      machine_type    = "e2-standard-4"
      max_nodes       = 5
      service_account = module.gke_sa.emails["gke-default"]
    }
    highmem = {
      machine_type    = "n2-highmem-4"
      max_nodes       = 3
      service_account = module.gke_sa.emails["gke-highmem"]
    }
  }
}

# Then use gcp/iam to grant roles to module.gke.node_pool_service_accounts["default"] and ["highmem"]
```

## Adding and removing node pools

You can change node pools over time by editing the `node_pools` map and running `terraform apply`:

- **Add a node pool**: Add a new entry to `node_pools` (e.g. add `highmem = { machine_type = "n2-highmem-4", max_nodes = 3 }`). Apply creates the new pool.
- **Remove a node pool**: Remove that entry from `node_pools`. Apply destroys that pool (ensure no critical workloads rely on it; drain nodes first if needed).

The cluster is unchanged; only the node pool resources are created or destroyed. You can start with one pool, add more later, or delete a pool when it’s no longer needed.

## IAM

- **node_pool_service_accounts** (output): Map of node pool name → service account email. Use each with **gcp/iam** to grant roles.
- **node_pools.*.service_account** (variable): Optional per-pool SA email. When set, that pool uses this SA; manage roles with **gcp/iam**. When null, the pool uses the GCP default Compute Engine SA.

## Cluster options

The module supports the main GKE cluster options that can be managed with Terraform. See `variables.tf` for types and defaults.

**Identity & access:** **master_authorized_networks**, **gcp_public_cidrs_access_enabled**, **enable_private_endpoint**, **master_global_access_enabled**, **master_ipv4_cidr_block**, **issue_client_certificate**, **workload_identity_config** (workload pool), **enable_identity_service**.

**Addons:** **http_load_balancing**, **horizontal_pod_autoscaling**, **network_policy** / **network_policy_provider** (e.g. CALICO), **dns_cache**, **filestore_csi_driver**, **gce_pd_csi_driver**, **gcs_fuse_csi_driver**, **config_connector**, **enable_secret_manager_addon**.

**Security:** **enable_binary_authorization**, **database_encryption** (application-layer secrets encryption), **security_posture_mode**, **security_posture_vulnerability_mode**, **enable_shielded_nodes**.

**DNS:** **cluster_dns**, **cluster_dns_scope**, **cluster_dns_domain**.

**Observability:** **enable_workload_logging** (logging_config), **monitoring_enabled_components**, **enable_managed_prometheus**.

**Maintenance:** **maintenance_start_hour**, **maintenance_days**, **maintenance_duration_hours**, **maintenance_exclusions** (name, start_time, end_time, optional exclusion_scope).

**Notifications:** **notification_config_topic** (Pub/Sub), **notification_config_event_types** (e.g. UPGRADE_AVAILABLE_EVENT, UPGRADE_EVENT, SECURITY_BULLETIN_EVENT).

**Network & datapath:** **disable_default_snat**, **datapath_provider** (e.g. ADVANCED_DATAPATH), **stack_type** (IPV4 / IPV4_IPV6), **enable_intranode_visibility**, **service_external_ips**, **enable_fqdn_network_policy**, **gateway_api_channel**.

**Other:** **description**, **deletion_protection**, **enable_vertical_pod_autoscaling**, **default_max_pods_per_node**, **enable_private_nodes**, **release_channel** / **kubernetes_version**, **enable_node_auto_provisioning** (and CPU/memory limits), **labels**.

## Node pool options (per pool)

Each entry in **node_pools** supports: **machine_type**, **disk_size_gb**, **disk_type** (pd-standard, pd-balanced, pd-ssd), **node_lifecycle** (SPOT/ON_DEMAND), **min_nodes**, **max_nodes**, **max_pods_per_node**, **zones**, **enable_secure_boot**, **service_account**, **image_type** (e.g. COS_CONTAINERD), **min_cpu_platform**, **taints**, **labels**, **tags** (network tags), **auto_repair**, **auto_upgrade**, **max_surge** / **max_unavailable** (upgrade rollout), and **guest_accelerator** (GPU: `{ type = "nvidia-tesla-t4", count = 1 }`). Covers the same node pool options as in `terraform-google-kubernetes-engine` (private-cluster node_config and upgrade_settings).

## Inputs / Outputs

See `variables.tf` and `outputs.tf`. Required: `project_id`, `region`, `cluster_name`, `network_self_link`, `subnetwork_self_link`, `secondary_range_pod`, `secondary_range_services`. **node_pools** can be empty (cluster only) or contain one or more pools.
