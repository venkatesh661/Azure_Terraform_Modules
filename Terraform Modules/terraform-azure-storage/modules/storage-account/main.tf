# Storage Account Module - Main Configuration
# Simplified Azure Storage Account configuration

# ==================== STORAGE ACCOUNT ====================

resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_kind             = var.account_kind
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  access_tier              = var.access_tier

  # Security settings
  https_traffic_only_enabled    = var.enable_https_traffic_only
  min_tls_version               = var.min_tls_version
  public_network_access_enabled = var.public_network_access_enabled

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags["CreatedDate"]
    ]
  }
}

# ==================== BLOB CONTAINERS ====================

resource "azurerm_storage_container" "containers" {
  for_each = var.enable_blob_containers ? var.containers : {}

  name                  = each.key
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = each.value.container_access_type
}

# ==================== FILE SHARES ====================

resource "azurerm_storage_share" "file_shares" {
  for_each = var.file_shares

  name                 = each.key
  storage_account_name = azurerm_storage_account.this.name
  quota                = each.value.quota
}
