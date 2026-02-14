# cloud-sql-mysql (Cloud SQL for MySQL)

Deploy **Cloud SQL for MySQL**: primary instance, optional read replicas, databases, and users. Supports standard networking or **Cloud SQL Proxy + IAM only** for access.

## Connection modes

- **Standard** (`proxy_iam_only = false`, default): Full control over `ip_configuration` and `user_host`. Use for any network or auth pattern.
- **Proxy + IAM only** (`proxy_iam_only = true`): All access via Cloud SQL Proxy with IAM:
  - `user_host` = `cloudsqlproxy~%`, `require_ssl` = true, no `authorized_networks`
  - Set `vpc_network` (and optionally `allocated_ip_range`) for private IP; set `assign_public_ip = true` if the instance should have a public IP (access still via Proxy + IAM).

## Usage (standard)

```hcl
module "cloud_sql_mysql" {
  source           = "./gcp/cloud-sql-mysql"
  project_id       = var.project_id
  name             = var.name
  database_version = "MYSQL_8_0"
  region           = var.region
  zone             = var.zone
  ip_configuration = { ... }
}
```

## Usage (Cloud SQL Proxy + IAM only)

```hcl
module "cloud_sql_mysql" {
  source           = "./gcp/cloud-sql-mysql"
  project_id       = var.project_id
  name             = var.name
  database_version = "MYSQL_8_0"
  region           = var.region
  zone             = var.zone
  proxy_iam_only   = true
  vpc_network      = "projects/my-project/global/networks/my-vpc"
  # assign_public_ip = true   # optional, if instance needs a public IP
}
```

## Inputs / Outputs

See `variables.tf` and `outputs.tf`. Required: `project_id`, `name`, `database_version`, `region`, `zone`. When `proxy_iam_only = true`, set `vpc_network` for private IP.
