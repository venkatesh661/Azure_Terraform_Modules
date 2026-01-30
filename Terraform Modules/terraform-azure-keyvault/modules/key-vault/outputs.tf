# Key Vault Module - Outputs

output "keyvault_id" {
  description = "The ID of the Key Vault"
  value       = azurerm_key_vault.keyvault.id
}

output "keyvault_name" {
  description = "The name of the Key Vault"
  value       = azurerm_key_vault.keyvault.name
}

output "keyvault_uri" {
  description = "The URI of the Key Vault"
  value       = azurerm_key_vault.keyvault.vault_uri
}

output "key_vault_resource_id" {
  description = "The full resource ID of the Key Vault"
  value       = azurerm_key_vault.keyvault.id
}

output "access_policies_count" {
  description = "The number of access policies configured"
  value       = length(azurerm_key_vault_access_policy.policies)
}

output "keyvault_tenant_id" {
  description = "The tenant ID of the Key Vault"
  value       = azurerm_key_vault.keyvault.tenant_id
}

output "keyvault_sku" {
  description = "The SKU name of the Key Vault"
  value       = azurerm_key_vault.keyvault.sku_name
}
