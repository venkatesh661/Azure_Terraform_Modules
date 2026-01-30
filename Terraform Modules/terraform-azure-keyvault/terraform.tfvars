
# Basic Configuration
keyvault_name       = "my-keyvault"
resource_group_name = "Venkat-Test-RG"
location            = "East US"
sku_name            = "standard"

# Access Configuration
# Set enable_rbac_authorization to false to use Access Policies
enable_rbac_authorization      = false
enabled_for_disk_encryption    = false
enabled_for_deployment         = false
enabled_for_template_deployment = false

# Network Configuration
public_network_access_enabled = false

# Purge Protection
purge_protection_enabled = false
soft_delete_retention_days = 7

# ==================== OPTION 1: ACCESS POLICIES ====================
# Use Access Policies when enable_rbac_authorization = false
# Comment this out if using RBAC instead

access_policies = {
  "azure reader" = {
    tenant_id = "ffdef3a4-6f16-4a1b-8401-39239d1b4f31"
    object_id = "11111111-1111-1111-1111-111111111111"  # User or Service Principal object ID
    certificate_permissions = ["Get", "List", "Create", "Update", "Delete"]
    key_permissions         = ["Get", "List", "Create", "Update", "Delete", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign"]
    secret_permissions      = ["Get", "List", "Set", "Delete"]
    storage_permissions     = ["Get", "List", "Delete", "Set", "Update", "RegenerateKey", "Recover", "Purge", "Backup", "Restore"]
  }
}

# ==================== OPTION 2: RBAC ROLE ASSIGNMENTS ====================
# Use RBAC when enable_rbac_authorization = true
# Comment this out if using Access Policies instead
# Common roles: "Key Vault Administrator", "Key Vault Secrets Officer", 
# "Key Vault Secrets User", "Key Vault Crypto Officer", "Key Vault Reader"

# rbac_assignments = {
#   "devops team admin" = {
#     principal_id         = "11111111-1111-1111-1111-111111111111"  # Object ID of user/group/service principal
#     role_definition_name = "Key Vault Administrator"
#     description          = "Full access to Key Vault for DevOps team"
#   }
#   "app service principal" = {
#     principal_id         = "22222222-2222-2222-2222-222222222222"
#     role_definition_name = "Key Vault Secrets User"
#     description          = "Read access to secrets for application"
#   }
# }

rbac_assignments = {}

# Tags
tags = {
  environment = "development"
  managed_by  = "terraform"
}


