# Redis Cache Module - Outputs

output "redis_id" {
  description = "The ID of the Redis Cache"
  value       = azurerm_redis_cache.redis.id
}

output "redis_name" {
  description = "The name of the Redis Cache"
  value       = azurerm_redis_cache.redis.name
}

output "redis_hostname" {
  description = "The hostname of the Redis Cache"
  value       = azurerm_redis_cache.redis.hostname
}

output "redis_ssl_port" {
  description = "The SSL port of the Redis Cache"
  value       = azurerm_redis_cache.redis.ssl_port
}

output "redis_port" {
  description = "The non-SSL port of the Redis Cache"
  value       = azurerm_redis_cache.redis.port
}

output "redis_primary_access_key" {
  description = "The primary access key for the Redis Cache"
  value       = azurerm_redis_cache.redis.primary_access_key
  sensitive   = true
}

output "redis_secondary_access_key" {
  description = "The secondary access key for the Redis Cache"
  value       = azurerm_redis_cache.redis.secondary_access_key
  sensitive   = true
}

output "redis_primary_connection_string" {
  description = "The primary connection string for the Redis Cache"
  value       = azurerm_redis_cache.redis.primary_connection_string
  sensitive   = true
}

output "redis_secondary_connection_string" {
  description = "The secondary connection string for the Redis Cache"
  value       = azurerm_redis_cache.redis.secondary_connection_string
  sensitive   = true
}

output "redis_identity" {
  description = "The Managed Identity block of the Redis Cache"
  value       = var.identity_type != null ? azurerm_redis_cache.redis.identity : null
}
