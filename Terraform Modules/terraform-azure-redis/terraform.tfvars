# Example terraform.tfvars for Azure Redis Cache

# Basic Configuration
redis_name          = "my-redis-cache"
resource_group_name = "my-resource-group"
location            = "East US"

# SKU Configuration
# Basic: Small cache, no replication (good for dev/test)
# Standard: Production-ready with replication (recommended for production)
# Premium: Advanced features like clustering, persistence, VNet
sku_name = "Standard"
family   = "C"        # C for Basic/Standard, P for Premium
capacity = 1          # 0-6 for C family, 1-5 for P family

# Redis Configuration
redis_version                 = "6"
enable_non_ssl_port           = false
minimum_tls_version           = "1.2"
public_network_access_enabled = true
enable_authentication         = true
maxmemory_policy              = "volatile-lru"

# Premium Features (uncomment if using Premium SKU)
# shard_count = 2
# zones       = ["1", "2", "3"]

# Backup Configuration (Premium only)
# rdb_backup_enabled            = true
# rdb_backup_frequency          = 60
# rdb_backup_max_snapshot_count = 1
# rdb_storage_connection_string = "DefaultEndpointsProtocol=https;AccountName=..."

# Managed Identity (optional)
# identity_type = "SystemAssigned"
# identity_ids  = []

# Tags
tags = {
  Environment = "Development"
  ManagedBy   = "Terraform"
  Project     = "Redis Cache Module"
}
