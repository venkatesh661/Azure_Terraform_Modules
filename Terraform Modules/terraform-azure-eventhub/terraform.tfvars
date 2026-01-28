# Example terraform.tfvars for Azure Event Hub

# Basic Configuration
eventhub_namespace_name = "my-eventhub-namespace"
eventhub_name           = "my-eventhub"
resource_group_name     = "my-resource-group"
location                = "East US"

# SKU Configuration
# Basic: 1 TU, 1 consumer group, 1 day retention
# Standard: Up to 20 TUs with auto-inflate, multiple consumer groups, up to 7 days retention
# Premium: Dedicated resources, VNet, encryption, geo-disaster recovery
sku      = "Standard"
capacity = 1

# Auto-Inflate Configuration (Standard and Premium only)
auto_inflate_enabled     = false
maximum_throughput_units = null

# Zone Redundancy (Premium only)
zone_redundant = false

# Event Hub Configuration
partition_count   = 2  # Number of partitions (2-32 for Basic/Standard, up to 100 for Premium)
message_retention = 1  # Days to retain messages (1-7 for Basic/Standard, up to 90 for Premium)

# Consumer Groups (optional)
consumer_groups = {
  # "app1" = {
  #   name          = "app1-consumer"
  #   user_metadata = "Consumer for Application 1"
  # }
  # "app2" = {
  #   name = "app2-consumer"
  # }
}

# Authorization Rules (optional)
authorization_rules = {
  # "send-only" = {
  #   send   = true
  #   listen = false
  #   manage = false
  # }
  # "listen-only" = {
  #   send   = false
  #   listen = true
  #   manage = false
  # }
  # "full-access" = {
  #   send   = true
  #   listen = true
  #   manage = true
  # }
}

# Managed Identity (optional)
# identity_type = "SystemAssigned"
# identity_ids  = []

# Tags
tags = {
  Environment = "Development"
  ManagedBy   = "Terraform"
  Project     = "Event Hub Module"
}
