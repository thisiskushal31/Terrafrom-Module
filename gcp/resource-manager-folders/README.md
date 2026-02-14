# resource-manager-folders

Standalone module: **Cloud Resource Manager** folders (and optional IAM). GCP product name: [Cloud Resource Manager → Folders](https://cloud.google.com/resource-manager/docs/creating-managing-folders). Only GCP resources here—no external module calls.

## Usage

```hcl
module "resource_manager_folders" {
  source   = "./gcp/resource-manager-folders"
  parent   = "organizations/123456789"
  names    = ["team-a", "team-b"]
  set_roles = true
  all_folder_admins = ["group:admins@example.com"]
}
```

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| parent | Parent: `folders/folder_id` or `organizations/org_id` | required |
| names | Folder display names | `[]` |
| prefix | Optional prefix for names | `""` |
| set_roles | Enable folder IAM | `false` |
| per_folder_admins | IAM per folder | `{}` |
| all_folder_admins | IAM on all folders | `[]` |
| folder_admin_roles | Roles when set_roles is true | (see variables.tf) |
| deletion_protection | Prevent destroy | `true` |

## Outputs

- `folders`, `ids`, `names`
