output "id" {
  description = "The resource id of the private dns zone"
  value       = azurerm_private_dns_zone.this.id
}

output "name" {
  description = "The name of the private dns zone"
  value       = azurerm_private_dns_zone.this.name
}
