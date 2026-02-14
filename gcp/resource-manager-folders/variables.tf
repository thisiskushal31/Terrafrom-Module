variable "parent" {
  type        = string
  description = "Parent: folders/folder_id or organizations/org_id (Cloud Resource Manager)"
}

variable "names" {
  type        = list(string)
  description = "Folder display names"
  default     = []
}

variable "prefix" {
  type        = string
  default     = ""
  description = "Optional prefix for folder names"
}

variable "set_roles" {
  type        = bool
  default     = false
  description = "Enable IAM bindings via per_folder_admins / all_folder_admins"
}

variable "per_folder_admins" {
  type = map(object({
    members = list(string)
    roles   = optional(list(string))
  }))
  default     = {}
  description = "IAM members (and optional roles) per folder"
}

variable "all_folder_admins" {
  type        = list(string)
  default     = []
  description = "IAM members to grant folder_admin_roles on all folders"
}

variable "folder_admin_roles" {
  type        = list(string)
  default     = ["roles/resourcemanager.folderViewer", "roles/resourcemanager.projectCreator"]
  description = "Default roles when set_roles is true"
}

variable "deletion_protection" {
  type        = bool
  default     = true
  description = "Prevent Terraform from destroying folders"
}
