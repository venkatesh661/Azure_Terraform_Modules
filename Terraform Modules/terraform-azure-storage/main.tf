# Root Module - Azure Storage Account
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
}

# Call the storage-account module
module "storage_account" {
  source = "./modules/storage-account"

  # Required configuration
  storage_account_name = var.storage_account_name
  resource_group_name  = var.resource_group_name
  location             = var.location

  # Storage account configuration
  account_kind             = var.account_kind
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  access_tier              = var.access_tier

  # Security settings
  min_tls_version               = var.min_tls_version
  public_network_access_enabled = var.public_network_access_enabled
  enable_https_traffic_only     = var.enable_https_traffic_only

  # Private endpoint
  private_endpoint_enabled = var.private_endpoint_enabled

  # Blob containers
  enable_blob_containers = var.enable_blob_containers
  containers             = var.containers

  # File shares
  file_shares = var.file_shares

  # Tags
  tags = var.tags
}
