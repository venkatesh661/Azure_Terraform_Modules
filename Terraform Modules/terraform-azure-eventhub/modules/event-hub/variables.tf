# Event Hub Module - Variables

# ==================== BASIC CONFIGURATION ====================

variable "eventhub_namespace_name" {
  description = "The name of the Event Hub Namespace"
  type        = string
}

variable "eventhub_name" {
  description = "The name of the Event Hub"
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

variable "capacity" {
  description = "Specifies the Capacity / Throughput Units for a Standard or Premium SKU namespace"
  type        = number
  default     = 1
}

# ==================== AUTO-INFLATE CONFIGURATION ====================

variable "auto_inflate_enabled" {
  description = "Is Auto Inflate enabled for the Event Hub Namespace?"
  type        = bool
  default     = false
}

variable "maximum_throughput_units" {
  description = "Specifies the maximum number of throughput units when Auto Inflate is enabled"
  type        = number
  default     = null
}

# ==================== ZONE REDUNDANCY ====================

variable "zone_redundant" {
  description = "Specifies if the Event Hub Namespace should be Zone Redundant (Premium SKU only)"
  type        = bool
  default     = false
}

# ==================== EVENT HUB CONFIGURATION ====================

variable "partition_count" {
  description = "Specifies the number of partitions for the Event Hub"
  type        = number
  default     = 2
}

variable "message_retention" {
  description = "Specifies the number of days to retain the events for this Event Hub"
  type        = number
  default     = 1
}

# ==================== CONSUMER GROUPS ====================

variable "consumer_groups" {
  description = "Map of consumer groups to create"
  type = map(object({
    name          = string
    user_metadata = optional(string)
  }))
  default = {}
}

# ==================== AUTHORIZATION RULES ====================

variable "create_authorization_rules" {
  description = "Set to true to create authorization rules"
  type        = bool
  default     = false
}

variable "authorization_rules" {
  description = "Map of authorization rules to create"
  type = map(object({
    listen = optional(bool)
    send   = optional(bool)
    manage = optional(bool)
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
  description = "List of User Assigned Identity IDs to assign to the Event Hub Namespace"
  type        = list(string)
  default     = null
}

# ==================== TAGS ====================

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default     = {}
}
