variable "name" {
  type        = string
  description = "(Required) Name of this DNS Zone."
  nullable    = false
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Resource group where the DNS Zone will be deployed."
  nullable    = false
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) Tags on this DNS Zone."
  validation {
    condition = alltrue([
      for k in keys(var.tags) : lower(k) != "tfc-module"
    ])
    error_message = "'tfc-module' is a reserved tag and must not be set by module consumers."
  }
}

variable "a_records" {
  type = list(object({
    name               = string
    ttl                = number
    records            = optional(list(string))
    target_resource_id = optional(string)
    tags               = optional(map(string), null)
  }))
  default     = []
  description = <<-EOT
    (Optional) A list of objects where each object contains information to create an `A` record.

    - `name` (Required) Name of the DNS A Record. Changing this forces a new resource to be created.
    - `ttl` (Required) Time To Live (TTL) of the DNS record in seconds.
    - `records` (Optional) List of IPv4 addresses for this A record. Must be specified if `target_resource_id` is not specified.
    - `target_resource_id` (Optional) The ID of the target Azure resource to which this record should point. Must be specified if `records` is not specified.
    - `tags` (Optional) A map of tags to assign to the record.
  EOT
  validation {
    condition = alltrue([
      for k, v in var.a_records : (
        !(v.records != null && v.target_resource_id != null) &&
        (v.records != null || v.target_resource_id != null)
      )
    ])
    error_message = "Either 'records' or 'target_resource_id' must be specified for each A record."
  }
}

variable "aaaa_records" {
  type = list(object({
    name               = string
    ttl                = number
    records            = optional(list(string))
    target_resource_id = optional(string)
    tags               = optional(map(string), null)
  }))
  default     = []
  description = <<-EOT
    (Optional) A list of objects where each object contains information to create an `AAAA` record.

    - `name` (Required) Name of the DNS AAAA Record. Changing this forces a new resource to be created.
    - `ttl` (Required) Time To Live (TTL) of the DNS record in seconds.
    - `records` (Optional) List of IPv6 addresses for this AAAA record. Must be specified if `target_resource_id` is not specified.
    - `target_resource_id` (Optional) The ID of the target Azure resource to which this record should point. Must be specified if `records` is not specified.
    - `tags` (Optional) A map of tags to assign to the record.
  EOT
  validation {
    condition = alltrue([
      for k, v in var.aaaa_records : (
        !(v.records != null && v.target_resource_id != null) &&
        (v.records != null || v.target_resource_id != null)
      )
    ])
    error_message = "Either 'records' or 'target_resource_id' must be specified for each AAAA record."
  }
}

variable "cname_records" {
  type = list(object({
    name               = string
    ttl                = number
    record             = string
    target_resource_id = optional(string)
    tags               = optional(map(string), null)
  }))
  default     = []
  description = <<-EOT
    (Optional) A list of objects where each object contains information to create a `CNAME` record.

    - `name` (Required) Name of the DNS CNAME Record. Changing this forces a new resource to be created.
    - `ttl` (Required) Time To Live (TTL) of the DNS record in seconds.
    - `record` (Optional) The target of the CNAME.
    - `target_resource_id` (Optional) The ID of the target Azure resource to which this record should point. Must be specified if `record` is not specified.
    - `tags` (Optional) A map of tags to assign to the record.
  EOT
  validation {
    condition = alltrue([
      for k, v in var.cname_records : (
        !(v.record != null && v.target_resource_id != null) &&
        (v.record != null || v.target_resource_id != null)
      )
    ])
    error_message = "Either 'record' or 'target_resource_id' must be specified for each CNAME record."
  }
}

variable "mx_records" {
  type = list(object({
    name = optional(string, "@")
    ttl  = number
    records = list(object({
      preference = number
      exchange   = string
    }))
    tags = optional(map(string), null)
  }))
  default     = []
  description = <<-EOT
    (Optional) A list of objects where each object contains information to create an `MX` record.

    - `name` (Optional) Name of the DNS MX Record. Defaults to `@` (root). Changing this forces a new resource to be created.
    - `ttl` (Required) Time To Live (TTL) of the DNS record in seconds.
    - `records` (Required) A list of objects that make up the MX record. Each object supports 2 fields:
        - `preference` (Required) Number representing the "preference” value of the MX records. Lower preference value takes priority.
        - `exchange` (Required) The mail server responsible for the domain of this MX record.
    - `tags` (Optional) A map of tags to assign to the record.
  EOT
}

variable "ns_records" {
  type = list(object({
    name    = string
    ttl     = number
    records = list(string)
    tags    = optional(map(string), null)
  }))
  default     = []
  description = <<-EOT
    (Optional) A list of objects where each object contains information to create an `NS` record.

    - `name` (Required) Name of the DNS NS Record. Changing this forces a new resource to be created.
    - `ttl` (Required) Time To Live (TTL) of the DNS record in seconds.
    - `records` (Required) A list of values that make up the NS record. Each value is the FQDN of a nameserver, ending with period (e.g. "ns1-06.azure-dns.com.").
    - `tags` (Optional) A map of tags to assign to the record.
  EOT
}

variable "ptr_records" {
  type = list(object({
    name    = string
    ttl     = number
    records = list(string)
    tags    = optional(map(string), null)
  }))
  default     = []
  description = <<-EOT
    (Optional) A list of objects where each object contains information to create a `PTR` record.

    - `name` (Required) Name of the DNS PTR Record. Changing this forces a new resource to be created.
    - `ttl` (Required) Time To Live (TTL) of the DNS record in seconds.
    - `records` (Required) A list of values that make up the PTR record. Each value is a FQDN.
    - `tags` (Optional) A map of tags to assign to the record.
  EOT
}

variable "srv_records" {
  type = list(object({
    name = string
    ttl  = number
    records = list(object({
      priority = number
      weight   = number
      port     = number
      target   = string
    }))
    tags = optional(map(string), null)
  }))
  default     = []
  description = <<-EOT
    (Optional) A list of objects where each object contains information to create a `SRV` record.

    - `name` (Optional) Name of the DNS SRV Record. Defaults to `@` (root). Changing this forces a new resource to be created.
    - `ttl` (Required) Time To Live (TTL) of the DNS record in seconds.
    - `records` (Required) A list of objects that make up the SRV record. Each object supports 4 fields:
        - `priority` (Required) Number representing the "priority" value of the SRV record. Lower priority value takes precedence.
        - `weight` (Required) Number representing the "weight" value of the SRV record. Higher weight value is preferred.
        - `port` (Required) The port on which the service is running.
        - `target` (Required) The hostname of the target host.
    - `tags` (Optional) A map of tags to assign to the record.
  EOT
}

variable "txt_records" {
  type = list(object({
    name    = string
    ttl     = number
    records = list(string)
    tags    = optional(map(string), null)
  }))
  default     = []
  description = <<-EOT
    (Optional) A list of objects where each object contains information to create a `TXT` record.

    - `name` (Required) Name of the DNS TXT Record. Changing this forces a new resource to be created.
    - `ttl` (Required) Time To Live (TTL) of the DNS record in seconds.
    - `records` (Required) A list of values that make up the TXT record.
    - `tags` (Optional) A map of tags to assign to the record.
  EOT
}
