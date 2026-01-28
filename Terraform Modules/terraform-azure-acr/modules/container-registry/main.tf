# Container Registry Module - Main Configuration
# Simplified Azure Container Registry configuration

# ==================== AZURE CONTAINER REGISTRY ====================

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled

  # Public network access
  public_network_access_enabled = var.public_network_access_enabled

  # Zone redundancy (Premium SKU only)
  zone_redundancy_enabled = var.sku == "Premium" ? var.zone_redundancy_enabled : false

  # Geo-replication (Premium SKU only)
  dynamic "georeplications" {
    for_each = var.sku == "Premium" && var.georeplications != null ? var.georeplications : []
    content {
      location                = georeplications.value.location
      zone_redundancy_enabled = lookup(georeplications.value, "zone_redundancy_enabled", false)
      tags                    = lookup(georeplications.value, "tags", var.tags)
    }
  }

  # Managed Identity
  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []
    content {
      type         = var.identity_type
      identity_ids = var.identity_type == "UserAssigned" || var.identity_type == "SystemAssigned, UserAssigned" ? var.identity_ids : null
    }
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags["CreatedDate"]
    ]
  }
}

# ==================== SCOPE MAP ====================

resource "azurerm_container_registry_scope_map" "scope_maps" {
  for_each = var.create_scope_maps ? var.scope_maps : {}

  name                    = each.key
  container_registry_name = azurerm_container_registry.acr.name
  resource_group_name     = var.resource_group_name
  actions                 = each.value.actions
}

# ==================== TOKEN ====================

resource "azurerm_container_registry_token" "tokens" {
  for_each = var.create_tokens ? var.tokens : {}

  name                    = each.key
  container_registry_name = azurerm_container_registry.acr.name
  resource_group_name     = var.resource_group_name
  scope_map_id            = azurerm_container_registry_scope_map.scope_maps[each.value.scope_map_name].id
  enabled                 = lookup(each.value, "enabled", true)
}

# ==================== WEBHOOK ====================

resource "azurerm_container_registry_webhook" "webhooks" {
  for_each = var.create_webhooks ? var.webhooks : {}

  name                = each.key
  registry_name       = azurerm_container_registry.acr.name
  resource_group_name = var.resource_group_name
  location            = var.location

  service_uri = each.value.service_uri
  actions     = each.value.actions
  status      = lookup(each.value, "status", "enabled")
  scope       = lookup(each.value, "scope", "")
  custom_headers = lookup(each.value, "custom_headers", {})

  tags = var.tags
}
