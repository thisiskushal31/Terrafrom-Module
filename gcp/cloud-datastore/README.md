# cloud-datastore

Create **Cloud Datastore** composite indexes. Enable the Datastore API in the project.

## Usage

```hcl
module "datastore_indexes" {
  source     = "./gcp/cloud-datastore"
  project_id = var.project_id
  indexes = [
    {
      id   = "team-program"
      kind = "Team"
      properties = [
        { name = "program", direction = "ASCENDING" },
        { name = "name", direction = "DESCENDING" }
      ]
    }
  ]
}
```

## Inputs

See `variables.tf`. Required: `project_id`. `indexes`: list of { id (optional), kind, ancestor (optional), properties (name, direction) }.

## Outputs

`index_ids`.
