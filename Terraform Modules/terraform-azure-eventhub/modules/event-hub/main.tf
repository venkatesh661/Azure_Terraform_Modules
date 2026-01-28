# Event Hub Module - Main Configuration
# Simplified Azure Event Hub configuration

# ==================== EVENT HUB NAMESPACE ====================

resource "azurerm_eventhub_namespace" "eventhub_namespace" {
  name                = var.eventhub_namespace_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  capacity            = var.capacity

  # Auto-inflate settings (Standard and Premium SKUs)
  auto_inflate_enabled     = var.auto_inflate_enabled
  maximum_throughput_units = var.auto_inflate_enabled ? var.maximum_throughput_units : null

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

# ==================== EVENT HUB ====================

resource "azurerm_eventhub" "eventhub" {
  name                = var.eventhub_name
  namespace_name      = azurerm_eventhub_namespace.eventhub_namespace.name
  resource_group_name = var.resource_group_name
  partition_count     = var.partition_count
  message_retention   = var.message_retention
}

# ==================== CONSUMER GROUPS ====================

resource "azurerm_eventhub_consumer_group" "consumer_groups" {
  for_each = var.consumer_groups

  name                = each.value.name
  namespace_name      = azurerm_eventhub_namespace.eventhub_namespace.name
  eventhub_name       = azurerm_eventhub.eventhub.name
  resource_group_name = var.resource_group_name
  user_metadata       = lookup(each.value, "user_metadata", null)
}

# ==================== AUTHORIZATION RULES ====================

resource "azurerm_eventhub_authorization_rule" "auth_rules" {
  for_each = var.create_authorization_rules ? var.authorization_rules : {}

  name                = each.key
  namespace_name      = azurerm_eventhub_namespace.eventhub_namespace.name
  eventhub_name       = azurerm_eventhub.eventhub.name
  resource_group_name = var.resource_group_name

  listen = lookup(each.value, "listen", false)
  send   = lookup(each.value, "send", false)
  manage = lookup(each.value, "manage", false)
}
