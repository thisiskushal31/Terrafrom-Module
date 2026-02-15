# compute-engine-instance

Standalone module: **Compute Engine** instance (single VM). GCP product: [Compute Engine](https://cloud.google.com/compute/docs/instances). Only GCP resources here—no external module calls. For managed instance groups use an instance template + MIG instead.

## Usage

```hcl
module "my_vm" {
  source                 = "./gcp/compute-engine-instance"
  project_id             = var.project_id
  zone                   = "asia-south1-a"
  instance_name          = "my-app-01"
  machine_type           = "e2-medium"
  boot_disk_size_gb      = 20
  gcp_image              = "ubuntu-os-cloud/ubuntu-2204-lts"
  subnetwork             = module.network.subnet_self_links["subnet-01"]
  service_account_email  = "my-sa@my-project.iam.gserviceaccount.com"
  network_tags           = ["http-server"]
  labels                 = { env = "prod" }
  enable_additional_disk = true
  additional_disk_size_gb = 50
}
```

**Startup script (optional):** Pass inline content or a GCS URL. Use `startup_script` with `file()` or `templatefile()` to run a script from a file at apply time:

```hcl
module "my_vm" {
  source        = "./gcp/compute-engine-instance"
  # ... other vars ...
  startup_script = file("${path.module}/scripts/init.sh")
  # Or from GCS only: startup_script_url = "gs://my-bucket/scripts/init.sh"
}
```

## Inputs / Outputs

See `variables.tf` and `outputs.tf`. Required: `project_id`, `zone`, `instance_name`, `subnetwork`, `service_account_email`. Optional: `startup_script`, `startup_script_url`.
