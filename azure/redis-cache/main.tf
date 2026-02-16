resource "azurerm_redis_cache" "this" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  capacity                    = var.capacity
  family                      = var.family
  sku_name                    = var.sku_name
  enable_non_ssl_port         = var.enable_non_ssl_port
  minimum_tls_version         = var.minimum_tls_version
  subnet_id                   = var.subnet_id
  private_static_ip_address   = var.private_static_ip_address
  redis_configuration         = length(var.redis_configuration) > 0 ? var.redis_configuration : null
  tags                        = var.tags
}
