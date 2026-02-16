terraform {
  required_version = ">= 0.13"
  required_providers {
    rediscloud = {
      source  = "RedisLabs/rediscloud"
      version = ">= 1.0"
    }
  }
}
