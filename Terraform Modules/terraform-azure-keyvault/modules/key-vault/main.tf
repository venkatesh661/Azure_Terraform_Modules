
# ==================== DATA SOURCES ====================

data "azurerm_client_config" "current" {}

# ==================== AZURE KEY VAULT ====================

resource "azurerm_key_vault" "keyvault" {
  name                = var.keyvault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  
  sku_name = var.sku_name

  # Access Configuration
  enable_rbac_authorization     = var.enable_rbac_authorization
  enabled_for_disk_encryption   = var.enabled_for_disk_encryption
  enabled_for_deployment        = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_template_deployment

  # Network Configuration
  public_network_access_enabled = var.public_network_access_enabled

  # Purge Protection and Soft Delete
  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled

  tags = var.tags
}

# ==================== KEY VAULT ACCESS POLICIES ====================

resource "azurerm_key_vault_access_policy" "policies" {
  for_each = var.access_policies

  key_vault_id       = azurerm_key_vault.keyvault.id
  tenant_id          = each.value.tenant_id
  object_id          = each.value.object_id
  application_id     = each.value.application_id

  certificate_permissions = each.value.certificate_permissions
  key_permissions         = each.value.key_permissions
  secret_permissions      = each.value.secret_permissions
  storage_permissions     = each.value.storage_permissions
}

# ==================== RBAC ROLE ASSIGNMENTS ====================

resource "azurerm_role_assignment" "rbac" {
  for_each = var.rbac_assignments

  scope                = azurerm_key_vault.keyvault.id
  role_definition_name = each.value.role_definition_name
  principal_id         = each.value.principal_id
  description          = each.value.description
}

