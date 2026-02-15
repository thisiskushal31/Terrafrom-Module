# group

Create a **Cloud Identity Group** and optionally add owners, managers, and members. Requires an organization (use `domain` or `customer_id`). Uses the Cloud Identity API (google-beta).

## Usage

```hcl
module "group" {
  source       = "./gcp/group"
  id           = "my-team@my-domain.com"
  display_name = "My Team"
  domain       = "my-domain.com"
  owners       = ["owner@my-domain.com"]
  members      = ["user1@my-domain.com", "user2@my-domain.com"]
}
```

## Inputs

See `variables.tf`. Required: `id`, and one of `domain` or `customer_id`. Optional: `display_name`, `description`, `initial_group_config`, `types`, `owners`, `managers`, `members`.

## Outputs

`group_id`, `group_name`.
