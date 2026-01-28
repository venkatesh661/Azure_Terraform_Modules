# Root Main Configuration - Azure Container Registry
# This file demonstrates how to use the Container Registry module

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

module "container_registry" {
  source = "./modules/container-registry"

  # Basic Configuration
  acr_name            = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location

  # SKU Configuration
  sku                           = var.sku
  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled

  # Zone Redundancy
  zone_redundancy_enabled = var.zone_redundancy_enabled

  # Geo-Replication
  georeplications = var.georeplications

  # Scope Maps
  create_scope_maps = var.create_scope_maps
  scope_maps        = var.scope_maps

  # Tokens
  create_tokens = var.create_tokens
  tokens        = var.tokens

  # Webhooks
  create_webhooks = var.create_webhooks
  webhooks        = var.webhooks

  # Managed Identity
  identity_type = var.identity_type
  identity_ids  = var.identity_ids

  # Tags
  tags = var.tags
}
