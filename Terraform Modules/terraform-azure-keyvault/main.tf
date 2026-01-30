
# ==================== MODULE USAGE ===================
module "key_vault" {
  source = "./modules/key-vault"

  # Basic Configuration
  keyvault_name       = var.keyvault_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tenant_id           = var.tenant_id

  # SKU Configuration
  sku_name = var.sku_name

  # Access Configuration
  enable_rbac_authorization     = var.enable_rbac_authorization
  enabled_for_disk_encryption   = var.enabled_for_disk_encryption
  enabled_for_deployment        = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_template_deployment
  
  # Network Configuration
  public_network_access_enabled = var.public_network_access_enabled

  # Purge Configuration
  purge_protection_enabled = var.purge_protection_enabled
  soft_delete_retention_days = var.soft_delete_retention_days

  # Access Policies
  access_policies = var.access_policies

  # RBAC Assignments
  rbac_assignments = var.rbac_assignments

  # Tags
  tags = var.tags
}
