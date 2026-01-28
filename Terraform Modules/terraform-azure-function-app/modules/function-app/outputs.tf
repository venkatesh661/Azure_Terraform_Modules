# Function App Module Outputs

output "function_app_id" {
  description = "The ID of the Function App"
  value       = var.os_type == "Linux" ? azurerm_linux_function_app.linux_function[0].id : azurerm_windows_function_app.windows_function[0].id
}

output "function_app_name" {
  description = "The name of the Function App"
  value       = var.os_type == "Linux" ? azurerm_linux_function_app.linux_function[0].name : azurerm_windows_function_app.windows_function[0].name
}

output "function_app_default_hostname" {
  description = "The default hostname of the Function App"
  value       = var.os_type == "Linux" ? azurerm_linux_function_app.linux_function[0].default_hostname : azurerm_windows_function_app.windows_function[0].default_hostname
}

output "function_app_principal_id" {
  description = "The principal ID for managed identity"
  value       = var.os_type == "Linux" ? try(azurerm_linux_function_app.linux_function[0].identity[0].principal_id, null) : try(azurerm_windows_function_app.windows_function[0].identity[0].principal_id, null)
}

output "app_service_plan_id" {
  description = "The ID of the App Service Plan"
  value       = azurerm_service_plan.app_service_plan.id
}

output "application_insights_id" {
  description = "The ID of Application Insights"
  value       = azurerm_application_insights.app_insights.id
}

output "application_insights_instrumentation_key" {
  description = "The instrumentation key for Application Insights"
  value       = azurerm_application_insights.app_insights.instrumentation_key
  sensitive   = true
}

output "application_insights_connection_string" {
  description = "The connection string for Application Insights"
  value       = azurerm_application_insights.app_insights.connection_string
  sensitive   = true
}
