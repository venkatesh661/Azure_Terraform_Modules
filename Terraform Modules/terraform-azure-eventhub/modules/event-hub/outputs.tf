# Event Hub Module - Outputs

# ==================== NAMESPACE OUTPUTS ====================

output "eventhub_namespace_id" {
  description = "The ID of the Event Hub Namespace"
  value       = azurerm_eventhub_namespace.eventhub_namespace.id
}

output "eventhub_namespace_name" {
  description = "The name of the Event Hub Namespace"
  value       = azurerm_eventhub_namespace.eventhub_namespace.name
}

output "eventhub_namespace_primary_connection_string" {
  description = "The primary connection string for the Event Hub Namespace"
  value       = azurerm_eventhub_namespace.eventhub_namespace.default_primary_connection_string
  sensitive   = true
}

output "eventhub_namespace_secondary_connection_string" {
  description = "The secondary connection string for the Event Hub Namespace"
  value       = azurerm_eventhub_namespace.eventhub_namespace.default_secondary_connection_string
  sensitive   = true
}

output "eventhub_namespace_primary_key" {
  description = "The primary access key for the Event Hub Namespace"
  value       = azurerm_eventhub_namespace.eventhub_namespace.default_primary_key
  sensitive   = true
}

output "eventhub_namespace_secondary_key" {
  description = "The secondary access key for the Event Hub Namespace"
  value       = azurerm_eventhub_namespace.eventhub_namespace.default_secondary_key
  sensitive   = true
}

# ==================== EVENT HUB OUTPUTS ====================

output "eventhub_id" {
  description = "The ID of the Event Hub"
  value       = azurerm_eventhub.eventhub.id
}

output "eventhub_name" {
  description = "The name of the Event Hub"
  value       = azurerm_eventhub.eventhub.name
}

output "eventhub_partition_ids" {
  description = "The identifiers for the partitions of this Event Hub"
  value       = azurerm_eventhub.eventhub.partition_ids
}

# ==================== CONSUMER GROUP OUTPUTS ====================

output "consumer_group_ids" {
  description = "Map of consumer group names to their IDs"
  value       = { for k, v in azurerm_eventhub_consumer_group.consumer_groups : k => v.id }
}

# ==================== AUTHORIZATION RULE OUTPUTS ====================

output "authorization_rule_ids" {
  description = "Map of authorization rule names to their IDs"
  value       = { for k, v in azurerm_eventhub_authorization_rule.auth_rules : k => v.id }
}

output "authorization_rule_primary_keys" {
  description = "Map of authorization rule names to their primary keys"
  value       = { for k, v in azurerm_eventhub_authorization_rule.auth_rules : k => v.primary_key }
  sensitive   = true
}

output "authorization_rule_primary_connection_strings" {
  description = "Map of authorization rule names to their primary connection strings"
  value       = { for k, v in azurerm_eventhub_authorization_rule.auth_rules : k => v.primary_connection_string }
  sensitive   = true
}

# ==================== IDENTITY OUTPUTS ====================

output "eventhub_namespace_identity" {
  description = "The Managed Identity block of the Event Hub Namespace"
  value       = var.identity_type != null ? azurerm_eventhub_namespace.eventhub_namespace.identity : null
}
