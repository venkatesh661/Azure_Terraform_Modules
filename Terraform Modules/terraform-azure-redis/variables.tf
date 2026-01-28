# Root Variables - Azure Redis Cache

# ==================== BASIC CONFIGURATION ====================

variable "redis_name" {
  description = "The name of the Redis Cache instance"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "East US"
}

# ==================== SKU CONFIGURATION ====================

variable "sku_name" {
  description = "The SKU of Redis to use. Possible values are Basic, Standard and Premium"
  type        = string
  default     = "Standard"
}

variable "family" {
  description = "The SKU family to use. Valid values are C (Basic/Standard) and P (Premium)"
  type        = string
  default     = "C"
}

variable "capacity" {
  description = "The size of the Redis cache to deploy. Valid values for C family: 0,1,2,3,4,5,6. Valid values for P family: 1,2,3,4,5"
  type        = number
  default     = 1
}

# ==================== REDIS CONFIGURATION ====================

variable "redis_version" {
  description = "Redis version. Possible values are 4 and 6"
  type        = string
  default     = "6"
}

variable "enable_non_ssl_port" {
  description = "Enable the non-SSL port (6379)"
  type        = bool
  default     = false
}

variable "minimum_tls_version" {
  description = "The minimum TLS version. Possible values are 1.0, 1.1 and 1.2"
  type        = string
  default     = "1.2"
}

variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for this Redis Cache"
  type        = bool
  default     = true
}

variable "enable_authentication" {
  description = "If set to false, the Redis instance will be accessible without authentication"
  type        = bool
  default     = true
}

variable "maxmemory_policy" {
  description = "How Redis will select what to remove when maxmemory is reached"
  type        = string
  default     = "volatile-lru"
}

# ==================== PREMIUM SKU FEATURES ====================

variable "shard_count" {
  description = "Number of shards to create on a Premium Cluster Cache (only for Premium SKU)"
  type        = number
  default     = null
}

variable "zones" {
  description = "A list of availability zones for Premium SKU"
  type        = list(string)
  default     = null
}

# ==================== BACKUP CONFIGURATION ====================

variable "rdb_backup_enabled" {
  description = "Enable or disable RDB persistence for this Redis Cache (Premium only)"
  type        = bool
  default     = false
}

variable "rdb_backup_frequency" {
  description = "The Backup Frequency in Minutes. Valid values: 15, 30, 60, 360, 720, 1440 (Premium only)"
  type        = number
  default     = null
}

variable "rdb_backup_max_snapshot_count" {
  description = "The maximum number of snapshots to create as a backup (Premium only)"
  type        = number
  default     = null
}

variable "rdb_storage_connection_string" {
  description = "The Connection String to the Storage Account for RDB persistence (Premium only)"
  type        = string
  default     = null
  sensitive   = true
}

# ==================== IDENTITY CONFIGURATION ====================

variable "identity_type" {
  description = "Type of Managed Identity (SystemAssigned, UserAssigned, or SystemAssigned, UserAssigned)"
  type        = string
  default     = null
}

variable "identity_ids" {
  description = "List of User Assigned Identity IDs to assign to the Redis Cache"
  type        = list(string)
  default     = null
}

# ==================== AZURE AUTHENTICATION ====================

variable "subscription_id" {
  description = "Azure subscription ID for authentication."
  type        = string
  sensitive   = true
}

variable "client_id" {
  description = "Azure service principal client ID."
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "Azure service principal client secret."
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure tenant ID."
  type        = string
  sensitive   = true
}

# ==================== TAGS ====================

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}
