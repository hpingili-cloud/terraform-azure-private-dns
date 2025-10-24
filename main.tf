locals {
  tags = merge(var.tags, local.module_tags)
  module_tags = {
    tfc-module = "private_dns_zone"
  }
  virtual_networks = [for vnet in var.virtual_networks : merge(provider::azapi::parse_resource_id("Microsoft.Network/virtualNetworks", vnet.id), vnet)]
}

resource "azurerm_private_dns_zone" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = local.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = { for vnet in local.virtual_networks : vnet.name => vnet }

  name                  = each.value.name
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = each.value.id
  registration_enabled  = each.value.registration_enabled
  tags                  = local.tags
}
