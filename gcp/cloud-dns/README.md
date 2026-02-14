# cloud-dns

Create a **Cloud DNS** managed zone (public or private) and record sets.

## Usage

```hcl
module "dns" {
  source     = "./gcp/cloud-dns"
  project_id = var.project_id
  name       = "my-zone"
  domain     = "example.com."
  type       = "private"
  private_visibility_config_networks = [module.network.network_self_link]
  recordsets = [
    { name = "", type = "A", ttl = 300, records = ["1.2.3.4"] },
    { name = "www", type = "CNAME", ttl = 300, records = ["example.com."] }
  ]
}
```

## Inputs

See `variables.tf`. Required: `project_id`, `name`, `domain`. Optional: `type` (public/private), `private_visibility_config_networks` (for private), `recordsets`.

## Outputs

`zone_name`, `zone_id`, `name_servers`, `dns_name`.
