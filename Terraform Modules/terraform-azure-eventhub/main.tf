# Root Main Configuration - Azure Event Hub
# This file demonstrates how to use the Event Hub module

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

module "event_hub" {
  source = "./modules/event-hub"

  # Basic Configuration
  eventhub_namespace_name = var.eventhub_namespace_name
  eventhub_name           = var.eventhub_name
  resource_group_name     = var.resource_group_name
  location                = var.location

  # SKU Configuration
  sku      = var.sku
  capacity = var.capacity

  # Auto-Inflate Configuration
  auto_inflate_enabled     = var.auto_inflate_enabled
  maximum_throughput_units = var.maximum_throughput_units

  # Zone Redundancy
  zone_redundant = var.zone_redundant

  # Event Hub Configuration
  partition_count   = var.partition_count
  message_retention = var.message_retention

  # Consumer Groups
  consumer_groups = var.consumer_groups

  # Authorization Rules
  create_authorization_rules = var.create_authorization_rules
  authorization_rules        = var.authorization_rules

  # Managed Identity
  identity_type = var.identity_type
  identity_ids  = var.identity_ids

  # Tags
  tags = var.tags
}
