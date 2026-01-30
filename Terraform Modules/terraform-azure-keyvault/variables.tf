# Root Variables - Azure Key Vault

# ==================== BASIC CONFIGURATION ====================

variable "keyvault_name" {
  description = "The name of the Key Vault"
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

variable "tenant_id" {
  description = "The tenant ID of the Azure subscription"
  type        = string
}

# ==================== SKU CONFIGURATION ====================

variable "sku_name" {
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium"
  type        = string
  default     = "standard"
}

# ==================== ACCESS CONFIGURATION ====================

variable "enable_rbac_authorization" {
  description = "Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions"
  type        = bool
  default     = false
  # Note: Set to false to use Access Policies instead of RBAC
}

variable "enabled_for_disk_encryption" {
  description = "Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys"
  type        = bool
  default     = false
}

variable "enabled_for_deployment" {
  description = "Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault"
  type        = bool
  default     = false
}

variable "enabled_for_template_deployment" {
  description = "Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault"
  type        = bool
  default     = false
}

# ==================== NETWORK CONFIGURATION ====================

variable "public_network_access_enabled" {
  description = "Whether the Key Vault is accessible from the public internet"
  type        = bool
  default     = true
}

# ==================== PURGE PROTECTION ====================

variable "purge_protection_enabled" {
  description = "Is Purge Protection enabled for this Key Vault?"
  type        = bool
  default     = false
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft-deleted"
  type        = number
  default     = 7
  
}

# ==================== ACCESS POLICIES ====================

variable "access_policies" {
  description = "Map of access policies for the Key Vault with group names as keys"
  type = map(object({
    tenant_id               = string
    object_id              = string
    application_id          = optional(string)
    certificate_permissions = optional(list(string), [])
    key_permissions         = optional(list(string), [])
    secret_permissions     = optional(list(string), [])
    storage_permissions    = optional(list(string), [])
  }))
  default = {}
}

# ==================== RBAC ASSIGNMENTS ====================

variable "rbac_assignments" {
  description = "Map of RBAC role assignments for the Key Vault with descriptive names as keys. Use this when enable_rbac_authorization is true."
  type = map(object({
    principal_id         = string
    role_definition_name = string
    description          = optional(string)
  }))
  default = {}
}

# ==================== TAGS ====================

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
  default     = {}
}

