# artifact-registry

Create an **Artifact Registry** repository for container images (Docker) or other formats (Maven, npm, Python, etc.). Use with GKE, Cloud Run, or CI/CD.

## Usage

```hcl
module "gar" {
  source       = "./gcp/artifact-registry"
  project_id   = var.project_id
  location     = "us-central1"
  repository_id = "my-docker-repo"
  format       = "DOCKER"
}
```

## Inputs

See `variables.tf`. Required: `project_id`, `location`, `repository_id`.

## Outputs

`repository_id`, `name`.
