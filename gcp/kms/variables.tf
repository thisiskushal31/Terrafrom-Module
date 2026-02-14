/**
 * KMS: key ring + crypto keys + optional IAM.
 */

variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "location" {
  type        = string
  description = "Location for the key ring (e.g. us-central1, global)"
}

variable "keyring" {
  type        = string
  description = "Key ring name"
}

variable "keys" {
  type = list(object({
    name             = string
    purpose          = optional(string, "ENCRYPT_DECRYPT")
    rotation_period  = optional(string)
    protection_level = optional(string, "SOFTWARE")
    algorithm        = optional(string, "GOOGLE_SYMMETRIC_ENCRYPTION")
    prevent_destroy  = optional(bool, true)
    labels           = optional(map(string), {})
  }))
  default     = []
  description = "List of crypto keys to create in the key ring"
}

variable "key_rotation_period" {
  type        = string
  default     = "7776000s"
  description = "Default rotation period (e.g. 7776000s = 90 days)"
}

variable "key_algorithm" {
  type        = string
  default     = "GOOGLE_SYMMETRIC_ENCRYPTION"
  description = "Default algorithm for key versions"
}

variable "key_protection_level" {
  type        = string
  default     = "SOFTWARE"
  description = "SOFTWARE or HSM"
}

variable "prevent_destroy" {
  type        = bool
  default     = true
  description = "Default prevent_destroy for keys"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Default labels for keys"
}

variable "key_iam_owners" {
  type        = map(list(string))
  default     = {}
  description = "Map of key name => list of members for EncrypterDecrypter"
}

variable "key_iam_encrypters" {
  type        = map(list(string))
  default     = {}
  description = "Map of key name => list of members for Encrypter"
}

variable "key_iam_decrypters" {
  type        = map(list(string))
  default     = {}
  description = "Map of key name => list of members for Decrypter"
}
