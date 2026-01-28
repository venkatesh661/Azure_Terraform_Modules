# Container Registry Module - Variables

# ==================== BASIC CONFIGURATION ====================

variable "acr_name" {
  description = "The name of the Container Registry"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

# ==================== SKU CONFIGURATION ====================

variable "sku" {
  description = "The SKU name. Possible values are Basic, Standard, Premium"
  type        = string
  default     = "Standard"
}

variable "admin_enabled" {
  description = "Enable admin user for the Container Registry"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for this Container Registry"
  type        = bool
  default     = true
}

# ==================== ZONE REDUNDANCY ====================

variable "zone_redundancy_enabled" {
  description = "Whether zone redundancy is enabled for this Container Registry (Premium SKU only)"
  type        = bool
  default     = false
}

# ==================== GEO-REPLICATION ====================

variable "georeplications" {
  description = "List of geo-replication configurations (Premium SKU only)"
  type = list(object({
    location                = string
    zone_redundancy_enabled = optional(bool)
    tags                    = optional(map(string))
  }))
  default = null
}

# ==================== SCOPE MAPS ====================

variable "create_scope_maps" {
  description = "Set to true to create scope maps"
  type        = bool
  default     = false
}

variable "scope_maps" {
  description = "Map of scope maps to create"
  type = map(object({
    actions = list(string)
  }))
  default = {}
}

# ==================== TOKENS ====================

variable "create_tokens" {
  description = "Set to true to create tokens"
  type        = bool
  default     = false
}

variable "tokens" {
  description = "Map of tokens to create"
  type = map(object({
    scope_map_name = string
    enabled        = optional(bool)
  }))
  default = {}
}

# ==================== WEBHOOKS ====================

variable "create_webhooks" {
  description = "Set to true to create webhooks"
  type        = bool
  default     = false
}

variable "webhooks" {
  description = "Map of webhooks to create"
  type = map(object({
    service_uri    = string
    actions        = list(string)
    status         = optional(string)
    scope          = optional(string)
    custom_headers = optional(map(string))
  }))
  default = {}
}

# ==================== IDENTITY CONFIGURATION ====================

variable "identity_type" {
  description = "Type of Managed Identity (SystemAssigned, UserAssigned, or SystemAssigned, UserAssigned)"
  type        = string
  default     = null
}

variable "identity_ids" {
  description = "List of User Assigned Identity IDs to assign to the Container Registry"
  type        = list(string)
  default     = null
}

# ==================== TAGS ====================

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default     = {}
}
