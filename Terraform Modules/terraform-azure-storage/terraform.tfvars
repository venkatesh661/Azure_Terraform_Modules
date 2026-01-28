
storage_account_name = "mystorageacct001"

# Resource group name - must already exist
resource_group_name = "my-resource-group"

# Azure region
location = "eastus"

account_kind = "StorageV2"

account_tier = "Standard"

# Replication type - Options: LRS, ZRS, GRS, RAGRS
account_replication_type = "LRS"

# Access tier - Options: Hot (frequent access), Cool (infrequent access)
access_tier = "Hot"

# ==================== SECURITY SETTINGS ====================

# Force HTTPS only (recommended)
enable_https_traffic_only = true

# Minimum TLS version (TLS1_2 recommended)
min_tls_version = "TLS1_2"

# Allow public network access
public_network_access_enabled = true

# ==================== PRIVATE ENDPOINT ====================

# Enable private endpoint
private_endpoint_enabled = false

# ==================== BLOB CONTAINERS ====================

# Enable blob containers
enable_blob_containers = true

# Define blob containers
containers = {
  "data" = {
    container_access_type = "private"
  }
  "backups" = {
    container_access_type = "private"
  }
}

# ==================== FILE SHARES ====================

# Define file shares
file_shares = {
  "documents" = {
    quota = 100
  }
}

# ==================== TAGS ====================

tags = {
  Environment = "Production"
  ManagedBy   = "Terraform"
  Project     = "Demo"
}
