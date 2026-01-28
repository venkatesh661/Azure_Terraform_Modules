# Redis Cache Module - Main Configuration
# Simplified Azure Redis Cache configuration

# ==================== AZURE REDIS CACHE ====================

resource "azurerm_redis_cache" "redis" {
  name                = var.redis_name
  resource_group_name = var.resource_group_name
  location            = var.location
  capacity            = var.capacity
  family              = var.family
  sku_name            = var.sku_name

  # Redis Configuration
  non_ssl_port_enabled          = var.enable_non_ssl_port
  minimum_tls_version           = var.minimum_tls_version
  public_network_access_enabled = var.public_network_access_enabled

  # Redis version
  redis_version = var.redis_version

  # Shard configuration for Premium SKU
  shard_count = var.sku_name == "Premium" ? var.shard_count : null

  # Zones for Premium SKU
  zones = var.sku_name == "Premium" && var.zones != null ? var.zones : null

  # Redis configuration settings
  redis_configuration {
    maxmemory_reserved              = var.maxmemory_reserved
    maxmemory_delta                 = var.maxmemory_delta
    maxmemory_policy                = var.maxmemory_policy
    maxfragmentationmemory_reserved = var.maxfragmentationmemory_reserved
    
    # AOF backup configuration (Premium only)
    aof_backup_enabled              = var.sku_name == "Premium" ? var.aof_backup_enabled : null
    aof_storage_connection_string_0 = var.sku_name == "Premium" && var.aof_backup_enabled ? var.aof_storage_connection_string_0 : null
    aof_storage_connection_string_1 = var.sku_name == "Premium" && var.aof_backup_enabled ? var.aof_storage_connection_string_1 : null
    
    # RDB backup configuration (Premium only)
    rdb_backup_enabled            = var.sku_name == "Premium" ? var.rdb_backup_enabled : null
    rdb_backup_frequency          = var.sku_name == "Premium" && var.rdb_backup_enabled ? var.rdb_backup_frequency : null
    rdb_backup_max_snapshot_count = var.sku_name == "Premium" && var.rdb_backup_enabled ? var.rdb_backup_max_snapshot_count : null
    rdb_storage_connection_string = var.sku_name == "Premium" && var.rdb_backup_enabled ? var.rdb_storage_connection_string : null
  }

  # Managed Identity
  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []
    content {
      type         = var.identity_type
      identity_ids = var.identity_type == "UserAssigned" || var.identity_type == "SystemAssigned, UserAssigned" ? var.identity_ids : null
    }
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags["CreatedDate"]
    ]
  }
}
