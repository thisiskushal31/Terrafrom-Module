# org-policy

Create one **Organization Policy** (boolean or list constraint) at a project, folder, or organization. Single responsibility: one policy per module instance.

## Usage

```hcl
# Boolean: disable serial port access on a project
module "org_policy" {
  source      = "./gcp/org-policy"
  parent_type = "project"
  parent_id   = var.project_id
  constraint  = "constraints/compute.disableSerialPortAccess"
  policy_type = "boolean"
  enforce     = true
}

# List: allow only specific APIs at folder
module "org_policy_list" {
  source        = "./gcp/org-policy"
  parent_type   = "folder"
  parent_id    = var.folder_id
  constraint   = "constraints/serviceuser.services"
  policy_type  = "list"
  allow_values = ["compute.googleapis.com", "storage.googleapis.com"]
}
```

## Inputs

See `variables.tf`. Required: `parent_type`, `parent_id`, `constraint`. For boolean: `enforce`. For list: `list_allow_all`, `list_deny_all`, or `allow_values`/`deny_values`.

## Outputs

`policy_name`, `policy_id`.
