# Storage Account Module Variables
# Simplified configuration based on resource requirements

# ==================== REQUIRED VARIABLES ====================

variable "storage_account_name" {
  description = "The name of the storage account. Must be globally unique across Azure. Only lowercase letters and numbers allowed. Length between 3-24 characters."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "Storage account name must be between 3-24 characters, contain only lowercase letters and numbers."
  }
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
}

variable "location" {
  description = "The Azure region where the storage account will be created. Examples: 'eastus', 'westeurope', 'southeastasia'."
  type        = string
}

# ==================== STORAGE ACCOUNT CONFIGURATION ====================

variable "account_kind" {
  description = "Defines the kind of storage account. Options: 'BlobStorage', 'StorageV2'."
  type        = string
  default     = "StorageV2"

  validation {
    condition     = contains(["BlobStorage", "StorageV2"], var.account_kind)
    error_message = "Account kind must be either 'BlobStorage' or 'StorageV2'."
  }
}

variable "account_tier" {
  description = "The performance tier of the storage account. 'Standard' (HDD-based) or 'Premium' (SSD-based)."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Account tier must be either 'Standard' or 'Premium'."
  }
}

variable "account_replication_type" {
  description = "The replication strategy. Options: 'LRS', 'ZRS', 'GRS', 'RAGRS'."
  type        = string
  default     = "LRS"

  validation {
    condition     = contains(["LRS", "ZRS", "GRS", "RAGRS"], var.account_replication_type)
    error_message = "Account replication type must be one of: LRS, ZRS, GRS, RAGRS."
  }
}

variable "access_tier" {
  description = "The access tier for the storage account. Options: 'Hot' (frequently accessed), 'Cool' (infrequently accessed)."
  type        = string
  default     = "Hot"

  validation {
    condition     = contains(["Hot", "Cool"], var.access_tier)
    error_message = "Access tier must be either 'Hot' or 'Cool'."
  }
}

variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account. Options: 'TLS1_0', 'TLS1_1', 'TLS1_2'."
  type        = string
  default     = "TLS1_2"

  validation {
    condition     = contains(["TLS1_0", "TLS1_1", "TLS1_2"], var.min_tls_version)
    error_message = "Minimum TLS version must be one of: TLS1_0, TLS1_1, TLS1_2."
  }
}

variable "public_network_access_enabled" {
  description = "Whether the storage account is accessible from public networks. Set to false to restrict to private endpoints only."
  type        = bool
  default     = true
}

variable "enable_https_traffic_only" {
  description = "Forces HTTPS traffic only. Recommended for security."
  type        = bool
  default     = true
}

# ==================== PRIVATE ENDPOINT ====================

variable "private_endpoint_enabled" {
  description = "Enable private endpoint for the storage account. Note: This variable indicates intent; actual private endpoint resource must be created separately."
  type        = bool
  default     = false
}

# ==================== BLOB CONTAINERS ====================

variable "enable_blob_containers" {
  description = "Enable creation of blob containers."
  type        = bool
  default     = true
}

variable "containers" {
  description = "Map of blob containers to create. Key is container name, value is object with container_access_type ('private', 'blob', 'container')."
  type = map(object({
    container_access_type = string
  }))
  default = {}

  validation {
    condition = alltrue([
      for k, v in var.containers : contains(["private", "blob", "container"], v.container_access_type)
    ])
    error_message = "Container access type must be one of: private, blob, container."
  }
}

# ==================== FILE SHARES ====================

variable "file_shares" {
  description = "Map of file shares to create. Key is share name, value is object with quota (in GB, range 1-102400)."
  type = map(object({
    quota = number
  }))
  default = {}

  validation {
    condition = alltrue([
      for k, v in var.file_shares : v.quota >= 1 && v.quota <= 102400
    ])
    error_message = "File share quota must be between 1 and 102400 GB."
  }
}

# ==================== TAGS ====================

variable "tags" {
  description = "A mapping of tags to assign to the storage account."
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
  }
}
