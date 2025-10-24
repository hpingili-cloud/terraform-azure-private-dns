locals {
  a_records_map     = { for record in var.a_records : record.name => record }
  aaaa_records_map  = { for record in var.aaaa_records : record.name => record }
  cname_records_map = { for record in var.cname_records : record.name => record }
  mx_records_map    = { for record in var.mx_records : record.name => record }
  ns_records_map    = { for record in var.ns_records : record.name => record }
  ptr_records_map   = { for record in var.ptr_records : record.name => record }
  srv_records_map   = { for record in var.srv_records : record.name => record }
  txt_records_map   = { for record in var.txt_records : record.name => record }

  zone_tags = merge(var.tags, local.module_tags)
  module_tags = {
    tfc-module = "dns_zone"
  }
}

resource "azurerm_dns_zone" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = local.zone_tags
}

resource "azurerm_dns_a_record" "this" {
  for_each = local.a_records_map

  resource_group_name = azurerm_dns_zone.this.resource_group_name
  name                = each.value.name
  ttl                 = each.value.ttl
  zone_name           = azurerm_dns_zone.this.name
  records             = each.value.records
  target_resource_id  = each.value.target_resource_id
  tags                = merge(lookup(each.value, "tags", null), local.module_tags)
}

resource "azurerm_dns_aaaa_record" "this" {
  for_each = local.aaaa_records_map

  resource_group_name = azurerm_dns_zone.this.resource_group_name
  name                = each.value.name
  ttl                 = each.value.ttl
  zone_name           = azurerm_dns_zone.this.name
  records             = each.value.records
  target_resource_id  = each.value.target_resource_id
  tags                = merge(lookup(each.value, "tags", null), local.module_tags)
}

resource "azurerm_dns_cname_record" "this" {
  for_each = local.cname_records_map

  resource_group_name = azurerm_dns_zone.this.resource_group_name
  name                = each.value.name
  ttl                 = each.value.ttl
  zone_name           = azurerm_dns_zone.this.name
  record              = each.value.record
  target_resource_id  = each.value.target_resource_id
  tags                = merge(lookup(each.value, "tags", null), local.module_tags)
}

resource "azurerm_dns_mx_record" "this" {
  for_each = local.mx_records_map

  resource_group_name = azurerm_dns_zone.this.resource_group_name
  name                = each.value.name
  ttl                 = each.value.ttl
  zone_name           = azurerm_dns_zone.this.name
  tags                = merge(lookup(each.value, "tags", null), local.module_tags)

  dynamic "record" {
    for_each = each.value.records

    content {
      exchange   = record.value.exchange
      preference = record.value.preference
    }
  }
}

resource "azurerm_dns_ns_record" "this" {
  for_each = local.ns_records_map

  resource_group_name = azurerm_dns_zone.this.resource_group_name
  name                = each.value.name
  ttl                 = each.value.ttl
  zone_name           = azurerm_dns_zone.this.name
  records             = each.value.records
  tags                = merge(lookup(each.value, "tags", null), local.module_tags)
}

resource "azurerm_dns_ptr_record" "this" {
  for_each = local.ptr_records_map

  resource_group_name = azurerm_dns_zone.this.resource_group_name
  name                = each.value.name
  ttl                 = each.value.ttl
  zone_name           = azurerm_dns_zone.this.name
  records             = each.value.records
  tags                = merge(lookup(each.value, "tags", null), local.module_tags)
}

resource "azurerm_dns_srv_record" "this" {
  for_each = local.srv_records_map

  resource_group_name = azurerm_dns_zone.this.resource_group_name
  name                = each.value.name
  ttl                 = each.value.ttl
  zone_name           = azurerm_dns_zone.this.name
  tags                = merge(lookup(each.value, "tags", null), local.module_tags)

  dynamic "record" {
    for_each = each.value.records

    content {
      port     = record.value.port
      priority = record.value.priority
      target   = record.value.target
      weight   = record.value.weight
    }
  }
}

resource "azurerm_dns_txt_record" "this" {
  for_each = local.txt_records_map

  resource_group_name = azurerm_dns_zone.this.resource_group_name
  name                = each.value.name
  ttl                 = each.value.ttl
  zone_name           = azurerm_dns_zone.this.name
  tags                = merge(lookup(each.value, "tags", null), local.module_tags)

  dynamic "record" {
    for_each = each.value.records

    content {
      value = record.value
    }
  }
}
