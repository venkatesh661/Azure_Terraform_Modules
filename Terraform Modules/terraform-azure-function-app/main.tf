# Root Module - Azure Function App
# Simplified configuration based on resource requirements

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

# Call the function-app module
module "function_app" {
  source = "./modules/function-app"

  # Required configuration
  function_app_name   = var.function_app_name
  resource_group_name = var.resource_group_name
  location            = var.location

  # Hosting Plan configuration
  hosting_plan_type = var.hosting_plan_type
  os_type           = var.os_type

  # Runtime configuration
  runtime_stack   = var.runtime_stack
  runtime_version = var.runtime_version

  # Application settings
  always_on                   = var.always_on
  app_insights_retention_days = var.app_insights_retention_days

  # Storage Account
  storage_account_name = var.storage_account_name

  # VNet Integration
  vnet_integration_enabled = var.vnet_integration_enabled
  subnet_id                = var.subnet_id

  # Managed Identity
  identity_type = var.identity_type
  identity_ids  = var.identity_ids

  # Scaling
  min_instances = var.min_instances
  max_instances = var.max_instances

  # Tags
  tags = var.tags
}
