variable "vm_name" {
  type        = string
  description = "Name of the VM"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name (from caller)"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID (from network module)"
}

variable "vm_size" {
  type        = string
  default     = "Standard_B2s"
  description = "VM size"
}

variable "os_type" {
  type        = string
  default     = "linux"
  description = "linux or windows"
}

variable "admin_username" {
  type        = string
  description = "Admin username"
}

variable "admin_password" {
  type        = string
  default     = null
  description = "Required for Windows"
  sensitive   = true
}

variable "admin_ssh_public_key" {
  type        = string
  default     = null
  description = "SSH public key for Linux"
}

variable "public_ip_address_id" {
  type        = string
  default     = null
  description = "Optional public IP for NIC"
}

variable "os_disk_storage_account_type" {
  type        = string
  default     = "Standard_LRS"
  description = "OS disk type"
}

variable "os_disk_size_gb" {
  type        = number
  default     = 128
  description = "OS disk size GB"
}

variable "image_publisher" {
  type        = string
  default     = "Canonical"
  description = "Image publisher"
}

variable "image_offer" {
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
  description = "Image offer"
}

variable "image_sku" {
  type        = string
  default     = "22_04-lts"
  description = "Image SKU"
}

variable "image_version" {
  type        = string
  default     = "latest"
  description = "Image version"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
