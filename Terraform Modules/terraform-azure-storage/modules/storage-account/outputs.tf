# Storage Account Module Outputs - Essential Only

output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.this.name
}

output "storage_account_primary_blob_endpoint" {
  description = "The primary blob endpoint URL"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "storage_account_primary_access_key" {
  description = "The primary access key"
  value       = azurerm_storage_account.this.primary_access_key
  sensitive   = true
}

output "storage_account_primary_connection_string" {
  description = "The primary connection string"
  value       = azurerm_storage_account.this.primary_connection_string
  sensitive   = true
}

output "storage_account_principal_id" {
  description = "The principal ID for managed identity"
  value       = try(azurerm_storage_account.this.identity[0].principal_id, null)
}

output "containers" {
  description = "Created blob containers"
  value       = { for k, v in azurerm_storage_container.containers : k => v.id }
}
