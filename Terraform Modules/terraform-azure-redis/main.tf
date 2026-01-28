# Root Main Configuration - Azure Redis Cache
# This file demonstrates how to use the Redis Cache module

terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

# ==================== MODULE USAGE ====================

module "redis_cache" {
  source = "./modules/redis-cache"

  # Basic Configuration
  redis_name          = var.redis_name
  resource_group_name = var.resource_group_name
  location            = var.location

  # SKU Configuration
  sku_name = var.sku_name
  family   = var.family
  capacity = var.capacity

  # Redis Configuration
  redis_version                 = var.redis_version
  enable_non_ssl_port           = var.enable_non_ssl_port
  minimum_tls_version           = var.minimum_tls_version
  public_network_access_enabled = var.public_network_access_enabled
  enable_authentication         = var.enable_authentication
  maxmemory_policy              = var.maxmemory_policy

  # Premium Features (only apply if sku_name = "Premium")
  shard_count = var.shard_count
  zones       = var.zones

  # Backup Configuration (Premium only)
  rdb_backup_enabled            = var.rdb_backup_enabled
  rdb_backup_frequency          = var.rdb_backup_frequency
  rdb_backup_max_snapshot_count = var.rdb_backup_max_snapshot_count
  rdb_storage_connection_string = var.rdb_storage_connection_string

  # Managed Identity
  identity_type = var.identity_type
  identity_ids  = var.identity_ids

  # Tags
  tags = var.tags
}
