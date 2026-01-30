# Azure Key Vault Terraform Module

This Terraform module creates and manages an Azure Key Vault with access policies (not RBAC).

## Features

- **Azure Key Vault**: Creation and configuration of Azure Key Vault
- **Access Policies**: Fine-grained access control using Key Vault Access Policies instead of RBAC
- **Secrets Management**: Ability to create and manage secrets in the Key Vault
- **Network Security**: Support for network ACLs to restrict access
- **Soft Delete**: Automatic soft deletion and purge protection support
- **Enterprise Features**: Support for both Standard and Premium SKUs

## Module Structure

```
terraform-azure-keyvault/
├── main.tf                    # Root configuration and module usage
├── variables.tf              # Root input variables
├── terraform.tfvars          # Example variable values
├── versions.tf               # Terraform and provider version requirements
├── modules/
│   └── key-vault/
│       ├── main.tf           # Key Vault resource definitions
│       ├── variables.tf       # Module input variables
│       └── outputs.tf         # Module outputs
└── README.md                 # This file
```

## Usage

### Basic Example

```hcl
module "key_vault" {
  source = "./modules/key-vault"

  keyvault_name       = "my-keyvault"
  resource_group_name = "my-resource-group"
  location            = "East US"
  tenant_id           = var.tenant_id
  
  sku_name = "standard"
  
  # Access Policies (instead of RBAC)
  access_policies = [
    {
      tenant_id          = var.tenant_id
      object_id          = "11111111-1111-1111-1111-111111111111"  # Your user/service principal
      secret_permissions = ["Get", "List", "Set", "Delete"]
    }
  ]
  
  tags = {
    environment = "development"
  }
}
```

### With Secrets

```hcl
module "key_vault" {
  source = "./modules/key-vault"

  keyvault_name       = "my-keyvault"
  resource_group_name = "my-resource-group"
  location            = "East US"
  tenant_id           = var.tenant_id
  
  # Create secrets
  secrets = {
    "db-password" = "your-password"
    "api-key"     = "your-api-key"
  }
  
  access_policies = [{
    tenant_id          = var.tenant_id
    object_id          = "11111111-1111-1111-1111-111111111111"
    secret_permissions = ["Get", "List", "Set", "Delete"]
  }]
}
```

## Access Policies vs RBAC

This module uses **Access Policies** instead of RBAC. Key differences:

| Feature | Access Policies | RBAC |
|---------|-----------------|------|
| Configuration | Direct in Key Vault | Azure's role system |
| Permissions | Custom per principal | Predefined roles |
| Scope | Key Vault level | Can be broader |
| Assignment | Individual principals | Any Azure resource |

To use RBAC instead, set `enable_rbac_authorization = true` in your variables.

## Key Vault Access Policy Permissions

### Secret Permissions
- `Get` - Get a secret
- `List` - List secrets
- `Set` - Create or update a secret
- `Delete` - Delete a secret
- `Recover` - Recover a deleted secret
- `Restore` - Restore a backed-up secret
- `Backup` - Back up a secret

### Key Permissions
- `Get` - Get a key
- `List` - List keys
- `Create` - Create a key
- `Update` - Update a key
- `Delete` - Delete a key
- `Decrypt` - Decrypt using a key
- `Encrypt` - Encrypt using a key
- `Sign` - Sign with a key
- `Verify` - Verify a signature
- `WrapKey` - Wrap a key
- `UnwrapKey` - Unwrap a key
- `Recover` - Recover a deleted key
- `Restore` - Restore a backed-up key
- `Backup` - Back up a key
- `Purge` - Permanently delete a key

### Certificate Permissions
- `Get` - Get a certificate
- `List` - List certificates
- `Create` - Create a certificate
- `Update` - Update a certificate
- `Delete` - Delete a certificate
- `ManageContacts` - Manage certificate contacts
- `ManageIssuers` - Manage certificate issuers
- `GetIssuers` - Get certificate issuers
- `ListIssuers` - List certificate issuers
- `SetIssuers` - Set certificate issuers
- `DeleteIssuers` - Delete certificate issuers
- `Import` - Import a certificate
- `Recover` - Recover a deleted certificate
- `Restore` - Restore a backed-up certificate
- `Backup` - Back up a certificate
- `Purge` - Permanently delete a certificate

### Storage Permissions
- `Get` - Get storage account
- `List` - List storage accounts
- `Delete` - Delete storage account
- `Set` - Set storage account
- `Update` - Update storage account
- `RegenerateKey` - Regenerate storage account key
- `Recover` - Recover deleted storage account
- `Restore` - Restore backed-up storage account
- `Backup` - Back up storage account
- `Purge` - Permanently delete storage account

## Variables

### Required Variables
- `keyvault_name` - Name of the Key Vault (3-24 characters)
- `resource_group_name` - Name of the resource group
- `location` - Azure region (default: "East US")
- `tenant_id` - Azure tenant ID

### Optional Variables
- `sku_name` - Key Vault SKU: "standard" or "premium" (default: "standard")
- `enable_rbac_authorization` - Use RBAC instead of access policies (default: false)
- `enabled_for_disk_encryption` - Allow Azure Disk Encryption (default: false)
- `enabled_for_deployment` - Allow VM deployment (default: false)
- `enabled_for_template_deployment` - Allow ARM template deployment (default: false)
- `public_network_access_enabled` - Public internet access (default: true)
- `network_acls` - Network ACLs for access control
- `purge_protection_enabled` - Enable purge protection (default: false)
- `soft_delete_retention_days` - Soft delete retention period 7-90 days (default: 7)
- `access_policies` - List of access policies
- `secrets` - Map of secrets to create
- `tags` - Tags to apply to resources

## Outputs

- `keyvault_id` - The ID of the Key Vault
- `keyvault_name` - The name of the Key Vault
- `keyvault_uri` - The URI of the Key Vault
- `key_vault_resource_id` - The full resource ID
- `secret_ids` - The IDs of created secrets
- `secret_versions` - The versions of created secrets
- `access_policies_count` - Number of configured access policies
- `keyvault_tenant_id` - The tenant ID of the Key Vault
- `keyvault_sku` - The SKU name of the Key Vault

## Getting Object IDs

To create access policies, you need object IDs for users, groups, or service principals:

### For Users
```bash
az ad user show --id user@example.com --query objectId -o tsv
```

### For Groups
```bash
az ad group show --group "group-name" --query objectId -o tsv
```

### For Service Principals
```bash
az ad sp show --id <app-id> --query objectId -o tsv
```

### Current User
```bash
az ad signed-in-user show --query objectId -o tsv
```

## Network Security

### Allow Specific IPs
```hcl
network_acls = {
  bypass         = "AzureServices"
  default_action = "Deny"
  ip_rules       = ["1.2.3.4/32", "5.6.7.8/32"]
}
```

### Allow Specific Subnets
```hcl
network_acls = {
  bypass         = "AzureServices"
  default_action = "Deny"
  virtual_network_subnet_ids = [
    "/subscriptions/xxx/resourceGroups/rg/providers/Microsoft.Network/virtualNetworks/vnet/subnets/subnet1"
  ]
}
```

## Security Best Practices

1. **Enable Purge Protection**: Prevents accidental deletion
   ```hcl
   purge_protection_enabled = true
   ```

2. **Use Network ACLs**: Restrict access to specific IPs/subnets
   ```hcl
   public_network_access_enabled = false
   network_acls = {
     default_action = "Deny"
     ip_rules       = ["your-ip"]
   }
   ```

3. **Least Privilege**: Grant minimum required permissions
   ```hcl
   secret_permissions = ["Get", "List"]  # Not "Set" or "Delete"
   ```

4. **Managed Identity**: Use Azure Managed Identities when possible

5. **Audit Logging**: Enable Key Vault logging and monitoring

## Troubleshooting

### Access Denied
- Verify the object ID in your access policy
- Check tenant ID matches your Azure subscription
- Ensure you have appropriate permissions to assign policies

### Key Vault Name Already Taken
- Key Vault names must be globally unique across Azure
- Try a different name or use a prefix

### Network ACL Issues
- Verify IP addresses are correct
- Check that "AzureServices" bypass is configured if needed
- Ensure service principals have access policies

## License

This module is provided as-is for educational and development purposes.
