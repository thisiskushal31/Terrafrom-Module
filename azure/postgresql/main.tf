resource "azurerm_postgresql_flexible_server" "this" {
  name                = var.server_name
  location            = var.location
  resource_group_name = var.resource_group_name
  version             = var.postgres_version
  administrator_login = var.administrator_login
  administrator_password = var.administrator_password
  sku_name            = var.sku_name
  storage_mb          = var.storage_mb
  zone                = var.zone
  delegated_subnet_id = var.delegated_subnet_id
  private_dns_zone_id = var.private_dns_zone_id
  public_network_access_enabled = var.public_network_access_enabled
  tags = var.tags
}

resource "azurerm_postgresql_flexible_server_database" "this" {
  for_each = toset(var.databases)

  name      = each.value
  server_id = azurerm_postgresql_flexible_server.this.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}
