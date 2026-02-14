# lb-http

Create a **global HTTP(S) load balancer**: optional global address, backend service (instance groups or NEGs), health check, URL map, and forwarding rule. Optionally attach SSL certificates for HTTPS.

## Usage

```hcl
module "lb" {
  source     = "./gcp/lb-http"
  project_id = var.project_id
  name       = "my-lb"
  create_address = true
  backend_groups = [google_compute_instance_group.my_ig.self_link]
  backend_port_name = "http"
  health_check_path = "/healthz"
}
# For HTTPS, set ssl_certificate_self_links to a list of certificate self links.
```

## Inputs

See `variables.tf`. Required: `project_id`, `name`. Optional: `backend_groups` (instance group or NEG self links), `create_address`/`address`, `ssl_certificate_self_links` (for HTTPS), health check and backend options.

## Outputs

`ip_address`, `backend_service_id`, `url_map_id`, `http_forwarding_rule_name`, `https_forwarding_rule_name`.
