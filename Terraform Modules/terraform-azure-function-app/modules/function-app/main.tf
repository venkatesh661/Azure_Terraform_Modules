# Function App Module - Main Configuration
# Simplified Azure Function App configuration

# ==================== APP SERVICE PLAN ====================

resource "azurerm_service_plan" "app_service_plan" {
  name                = "${var.function_app_name}-plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type

  # SKU configuration based on hosting plan type
  sku_name = var.hosting_plan_type == "Consumption" ? "Y1" : (var.hosting_plan_type == "Premium" ? "EP1" : "P1v2")

  tags = var.tags
}

# ==================== APPLICATION INSIGHTS ====================

resource "azurerm_application_insights" "app_insights" {
  name                = "${var.function_app_name}-appinsights"
  resource_group_name = var.resource_group_name
  location            = var.location
  application_type    = "web"
  retention_in_days   = var.app_insights_retention_days

  tags = var.tags
}

# ==================== FUNCTION APP ====================

resource "azurerm_linux_function_app" "linux_function" {
  count = var.os_type == "Linux" ? 1 : 0

  name                       = var.function_app_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  service_plan_id            = azurerm_service_plan.app_service_plan.id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = data.azurerm_storage_account.storage.primary_access_key

  site_config {
    always_on = var.hosting_plan_type != "Consumption" ? var.always_on : false

    application_stack {
      # Dynamic runtime configuration based on runtime_stack
      dotnet_version = var.runtime_stack == "dotnet" ? var.runtime_version : null
      node_version   = var.runtime_stack == "node" ? var.runtime_version : null
      python_version = var.runtime_stack == "python" ? var.runtime_version : null
      java_version   = var.runtime_stack == "java" ? var.runtime_version : null
    }

    # VNet integration
    vnet_route_all_enabled = var.vnet_integration_enabled
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = azurerm_application_insights.app_insights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.app_insights.connection_string
    "FUNCTIONS_WORKER_RUNTIME"              = var.runtime_stack
  }

  # Managed Identity
  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []
    content {
      type         = var.identity_type
      identity_ids = var.identity_type == "UserAssigned" || var.identity_type == "SystemAssigned, UserAssigned" ? var.identity_ids : null
    }
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags["CreatedDate"]
    ]
  }
}

resource "azurerm_windows_function_app" "windows_function" {
  count = var.os_type == "Windows" ? 1 : 0

  name                       = var.function_app_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  service_plan_id            = azurerm_service_plan.app_service_plan.id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = data.azurerm_storage_account.storage.primary_access_key

  site_config {
    always_on = var.hosting_plan_type != "Consumption" ? var.always_on : false

    application_stack {
      # Dynamic runtime configuration for Windows (supports: dotnet, node, java - NO python)
      dotnet_version = var.runtime_stack == "dotnet" ? var.runtime_version : null
      node_version   = var.runtime_stack == "node" ? var.runtime_version : null
      java_version   = var.runtime_stack == "java" ? var.runtime_version : null
    }

    # VNet integration
    vnet_route_all_enabled = var.vnet_integration_enabled
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = azurerm_application_insights.app_insights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.app_insights.connection_string
    "FUNCTIONS_WORKER_RUNTIME"              = var.runtime_stack
  }

  # Managed Identity
  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []
    content {
      type         = var.identity_type
      identity_ids = var.identity_type == "UserAssigned" || var.identity_type == "SystemAssigned, UserAssigned" ? var.identity_ids : null
    }
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags["CreatedDate"]
    ]
  }
}

# ==================== VNET INTEGRATION ====================

resource "azurerm_app_service_virtual_network_swift_connection" "vnet_integration" {
  count = var.vnet_integration_enabled && var.subnet_id != null ? 1 : 0

  app_service_id = var.os_type == "Linux" ? azurerm_linux_function_app.linux_function[0].id : azurerm_windows_function_app.windows_function[0].id
  subnet_id      = var.subnet_id
}

# ==================== DATA SOURCES ====================

data "azurerm_storage_account" "storage" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}
