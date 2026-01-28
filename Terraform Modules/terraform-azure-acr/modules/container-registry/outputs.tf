# Container Registry Module - Outputs

# ==================== CONTAINER REGISTRY OUTPUTS ====================

output "acr_id" {
  description = "The ID of the Container Registry"
  value       = azurerm_container_registry.acr.id
}

output "acr_name" {
  description = "The name of the Container Registry"
  value       = azurerm_container_registry.acr.name
}

output "acr_login_server" {
  description = "The login server URL of the Container Registry"
  value       = azurerm_container_registry.acr.login_server
}

output "acr_admin_username" {
  description = "The admin username of the Container Registry"
  value       = var.admin_enabled ? azurerm_container_registry.acr.admin_username : null
  sensitive   = true
}

output "acr_admin_password" {
  description = "The admin password of the Container Registry"
  value       = var.admin_enabled ? azurerm_container_registry.acr.admin_password : null
  sensitive   = true
}

output "acr_identity" {
  description = "The Managed Identity block of the Container Registry"
  value       = var.identity_type != null ? azurerm_container_registry.acr.identity : null
}

# ==================== SCOPE MAP OUTPUTS ====================

output "scope_map_ids" {
  description = "Map of scope map names to their IDs"
  value       = { for k, v in azurerm_container_registry_scope_map.scope_maps : k => v.id }
}

# ==================== TOKEN OUTPUTS ====================

output "token_ids" {
  description = "Map of token names to their IDs"
  value       = { for k, v in azurerm_container_registry_token.tokens : k => v.id }
}

# ==================== WEBHOOK OUTPUTS ====================

output "webhook_ids" {
  description = "Map of webhook names to their IDs"
  value       = { for k, v in azurerm_container_registry_webhook.webhooks : k => v.id }
}
