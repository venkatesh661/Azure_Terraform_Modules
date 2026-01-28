# Example terraform.tfvars for Azure Container Registry

# Basic Configuration
acr_name            = "mycontainerregistry001"
resource_group_name = "my-resource-group"
location            = "East US"

# SKU Configuration
# Basic: Limited storage and throughput, good for dev/test
# Standard: Increased storage and throughput, suitable for production
# Premium: Highest storage, geo-replication, content trust, customer-managed keys
sku                           = "Standard"
admin_enabled                 = false
public_network_access_enabled = true

# Zone Redundancy (Premium only)
zone_redundancy_enabled = false

# Geo-Replication (Premium only)
# georeplications = [
#   {
#     location                = "West US"
#     zone_redundancy_enabled = false
#   }
# ]

# Scope Maps (optional)
create_scope_maps = false
# scope_maps = {
#   "pull-only" = {
#     actions = [
#       "repositories/*/content/read",
#       "repositories/*/metadata/read"
#     ]
#   }
# }

# Tokens (optional)
create_tokens = false
# tokens = {
#   "pull-token" = {
#     scope_map_name = "pull-only"
#     enabled        = true
#   }
# }

# Webhooks (optional)
create_webhooks = false
# webhooks = {
#   "docker-push" = {
#     service_uri = "https://myapp.example.com/webhook"
#     actions     = ["push"]
#     status      = "enabled"
#   }
# }

# Managed Identity (optional)
# identity_type = "SystemAssigned"
# identity_ids  = []

# Tags
tags = {
  Environment = "Development"
  ManagedBy   = "Terraform"
  Project     = "Container Registry Module"
}
