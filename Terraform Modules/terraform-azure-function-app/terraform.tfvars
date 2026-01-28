
# ==================== REQUIRED VARIABLES ====================

# Function App name - must be globally unique
function_app_name = "myfunction001"

# Resource group name - must already exist
resource_group_name = "kloudsavvy-commonRG"

# Azure region
location = "eastus"

# ==================== HOSTING PLAN ====================

# Hosting plan type - Options: Consumption, Premium, Dedicated
hosting_plan_type = "Consumption"

# OS type - Options: Windows, Linux
os_type = "Windows"

# ==================== RUNTIME CONFIGURATION ====================

# Runtime stack - Options: dotnet, node, python, java
runtime_stack = "dotnet"

# Runtime version - Examples: v6.0 for .NET, 18 for Node, 3.9 for Python, 11 for Java
runtime_version = "v6.0"

# ==================== APPLICATION SETTINGS ====================

# Always On (not available for Consumption plan)
always_on = false

# Application Insights retention in days (30-730)
app_insights_retention_days = 90

# ==================== STORAGE ACCOUNT ====================

# Storage account name - must already exist
storage_account_name = "kloudsavvylms"

# ==================== VNET INTEGRATION ==========s==========

# Enable VNet integration
vnet_integration_enabled = false

# Subnet ID for VNet integration (required if vnet_integration_enabled = true)
# subnet_id = "/subscriptions/xxxxx/resourceGroups/rg/providers/Microsoft.Network/virtualNetworks/vnet/subnets/subnet"
subnet_id = null

# ==================== MANAGED IDENTITY ====================

# Identity type - Options: SystemAssigned, UserAssigned, "SystemAssigned, UserAssigned", null
identity_type = "SystemAssigned"

# User-assigned identity IDs (required if identity_type includes UserAssigned)
identity_ids = []

# ==================== SCALING ====================

# Minimum instances
min_instances = 1

# Maximum instances
max_instances = 10

# ==================== TAGS ====================

tags = {
  Environment = "Production"
  ManagedBy   = "Terraform"
  Project     = "Demo"
}
