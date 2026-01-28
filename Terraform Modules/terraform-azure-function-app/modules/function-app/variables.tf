
variable "function_app_name" {
  description = "The name of the Function App. Must be globally unique."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Function App."
  type        = string
}

variable "location" {
  description = "The Azure region where the Function App will be created."
  type        = string
}

# ==================== HOSTING PLAN ====================

variable "hosting_plan_type" {
  description = "The type of hosting plan. Options: 'Consumption', 'Premium', 'Dedicated'."
  type        = string
  default     = "Consumption"

  validation {
    condition     = contains(["Consumption", "Premium", "Dedicated"], var.hosting_plan_type)
    error_message = "Hosting plan type must be one of: Consumption, Premium, Dedicated."
  }
}

variable "os_type" {
  description = "The operating system type. Options: 'Windows', 'Linux'."
  type        = string
  default     = "Windows"

  validation {
    condition     = contains(["Windows", "Linux"], var.os_type)
    error_message = "OS type must be either 'Windows' or 'Linux'."
  }
}

# ==================== RUNTIME CONFIGURATION ====================

variable "runtime_stack" {
  description = "The runtime stack for the Function App. Options: 'dotnet', 'node', 'python', 'java'."
  type        = string
  default     = "dotnet"

  validation {
    condition     = contains(["dotnet", "node", "python", "java"], var.runtime_stack)
    error_message = "Runtime stack must be one of: dotnet, node, python, java."
  }
}

variable "runtime_version" {
  description = "The version of the runtime stack."
  type        = string
  default     = "6.0"
}

# ==================== APPLICATION SETTINGS ====================

variable "always_on" {
  description = "Keep the Function App always running."
  type        = bool
  default     = false
}

variable "app_insights_retention_days" {
  description = "Number of days to retain Application Insights data."
  type        = number
  default     = 90

  validation {
    condition     = var.app_insights_retention_days >= 30 && var.app_insights_retention_days <= 730
    error_message = "App Insights retention days must be between 30 and 730."
  }
}

# ==================== STORAGE ACCOUNT ====================

variable "storage_account_name" {
  description = "The name of the storage account to be used by the Function App."
  type        = string
}

# ==================== VNET INTEGRATION ====================

variable "vnet_integration_enabled" {
  description = "Enable VNet integration for the Function App."
  type        = bool
  default     = false
}

variable "subnet_id" {
  description = "The subnet ID for VNet integration."
  type        = string
  default     = null
}

# ==================== MANAGED IDENTITY ====================

variable "identity_type" {
  description = "The type of Managed Identity. Options: 'SystemAssigned', 'UserAssigned', 'SystemAssigned, UserAssigned', or null."
  type        = string
  default     = "SystemAssigned"

  validation {
    condition     = var.identity_type == null || contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity_type)
    error_message = "Identity type must be one of: SystemAssigned, UserAssigned, 'SystemAssigned, UserAssigned', or null."
  }
}

variable "identity_ids" {
  description = "List of User Assigned Managed Identity IDs."
  type        = list(string)
  default     = []
}

# ==================== SCALING ====================

variable "min_instances" {
  description = "Minimum number of instances."
  type        = number
  default     = 1

  validation {
    condition     = var.min_instances >= 0 && var.min_instances <= 100
    error_message = "Minimum instances must be between 0 and 100."
  }
}

variable "max_instances" {
  description = "Maximum number of instances."
  type        = number
  default     = 10

  validation {
    condition     = var.max_instances >= 1 && var.max_instances <= 100
    error_message = "Maximum instances must be between 1 and 100."
  }
}

# ==================== TAGS ====================

variable "tags" {
  description = "A mapping of tags to assign to the Function App."
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
  }
}
