resource "rediscloud_subscription" "this" {
  name                   = var.subscription_name
  payment_method         = var.payment_method
  payment_method_id      = var.payment_method_id
  public_endpoint_access = var.public_endpoint_access

  cloud_provider {
    provider         = "AZURE"
    cloud_account_id = var.cloud_account_id

    region {
      region                       = var.region
      multiple_availability_zones  = var.multiple_availability_zones
      networking_deployment_cidr   = var.networking_deployment_cidr
      preferred_availability_zones = var.preferred_availability_zones
    }
  }

  creation_plan {
    dataset_size_in_gb           = var.dataset_size_in_gb
    quantity                     = var.creation_plan_quantity
    replication                  = var.replication
    throughput_measurement_by    = var.throughput_measurement_by
    throughput_measurement_value = var.throughput_measurement_value
  }
}

resource "rediscloud_subscription_database" "this" {
  subscription_id             = rediscloud_subscription.this.id
  name                       = var.database_name
  dataset_size_in_gb         = var.dataset_size_in_gb
  throughput_measurement_by  = var.throughput_measurement_by
  throughput_measurement_value = var.throughput_measurement_value
  replication                = var.replication
  data_persistence           = var.data_persistence
  tags                       = var.tags
}
