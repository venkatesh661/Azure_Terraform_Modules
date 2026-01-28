# Root Module Outputs - Essential Only

output "storage_account_id" {
  description = "The ID of the storage account"
  value       = module.storage_account.storage_account_id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = module.storage_account.storage_account_name
}

output "storage_account_primary_blob_endpoint" {
  description = "The primary blob endpoint URL"
  value       = module.storage_account.storage_account_primary_blob_endpoint
}

output "storage_account_primary_access_key" {
  description = "The primary access key"
  value       = module.storage_account.storage_account_primary_access_key
  sensitive   = true
}

output "storage_account_primary_connection_string" {
  description = "The primary connection string"
  value       = module.storage_account.storage_account_primary_connection_string
  sensitive   = true
}

output "storage_account_principal_id" {
  description = "The principal ID for managed identity"
  value       = module.storage_account.storage_account_principal_id
}

output "containers" {
  description = "Created blob containers"
  value       = module.storage_account.containers
}
