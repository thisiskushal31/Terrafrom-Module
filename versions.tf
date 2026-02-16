# Root Terraform version — use when running all modules with one version.
# When you run Terraform from a root that calls these modules (this repo root or
# your Infra Orchestrator root), use this block there so one Terraform + provider
# version applies everywhere. For version-agnostic use (different versions per
# context), omit this and set required_version/required_providers in your own root only.

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = ">= 2.0"
    }
    rediscloud = {
      source  = "RedisLabs/rediscloud"
      version = ">= 1.0"
    }
    confluent = {
      source  = "confluentinc/confluent"
      version = ">= 1.0"
    }
  }
}
