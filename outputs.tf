output "a_record_outputs" {
  description = "The a record output"
  value = {
    for record_name, record in azurerm_dns_a_record.this :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "cname_record_outputs" {
  description = "The cname record output"
  value = {
    for record_name, record in azurerm_dns_cname_record.this :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "max_number_of_record_sets" {
  description = "Maximum number of Records in Zone output"
  value       = azurerm_dns_zone.this.max_number_of_record_sets
}

output "mx_record_outputs" {
  description = "The mx record output"
  value = {
    for record_name, record in azurerm_dns_mx_record.this :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "name_servers" {
  description = "List of values that make up NS Record for Zone"
  value       = azurerm_dns_zone.this.name_servers
}

output "ns_record_outputs" {
  description = "The ns record output"
  value = {
    for record_name, record in azurerm_dns_ns_record.this :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "number_of_record_sets" {
  description = "Number of records in DNS Zone"
  value       = azurerm_dns_zone.this.number_of_record_sets
}

output "ptr_record_outputs" {
  description = "The ptr record output"
  value = {
    for record_name, record in azurerm_dns_ptr_record.this :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "id" {
  description = "Azure resource id of DNS Zone"
  value       = azurerm_dns_zone.this.id
}

output "name" {
  description = "The name of the DNS Zone"
  value       = azurerm_dns_zone.this.name
}

output "srv_record_outputs" {
  description = "The srv record output"
  value = {
    for record_name, record in azurerm_dns_srv_record.this :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "txt_record_outputs" {
  description = "The txt record output"
  value = {
    for record_name, record in azurerm_dns_txt_record.this :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}
