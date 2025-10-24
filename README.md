<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.9)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 4.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (~> 4.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [azurerm_dns_a_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) (resource)
- [azurerm_dns_aaaa_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_aaaa_record) (resource)
- [azurerm_dns_cname_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) (resource)
- [azurerm_dns_mx_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_mx_record) (resource)
- [azurerm_dns_ns_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) (resource)
- [azurerm_dns_ptr_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ptr_record) (resource)
- [azurerm_dns_srv_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_srv_record) (resource)
- [azurerm_dns_txt_record.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_txt_record) (resource)
- [azurerm_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_name"></a> [name](#input\_name)

Description: (Required) Name of this DNS Zone.

Type: `string`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: (Required) Resource group where the DNS Zone will be deployed.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_a_records"></a> [a\_records](#input\_a\_records)

Description: (Optional) A list of objects where each object contains information to create an `A` record.

- `name` (Required) Name of the DNS A Record. Changing this forces a new resource to be created.
- `ttl` (Required) Time To Live (TTL) of the DNS record in seconds.
- `records` (Optional) List of IPv4 addresses for this A record. Must be specified if `target_resource_id` is not specified.
- `target_resource_id` (Optional) The ID of the target Azure resource to which this record should point. Must be specified if `records` is not specified.
- `tags` (Optional) A map of tags to assign to the record.

Type:

```hcl
list(object({
    name               = string
    ttl                = number
    records            = optional(list(string))
    target_resource_id = optional(string)
    tags               = optional(map(string), null)
  }))
```

Default: `[]`

### <a name="input_aaaa_records"></a> [aaaa\_records](#input\_aaaa\_records)

Description: (Optional) A list of objects where each object contains information to create an `AAAA` record.

- `name` (Required) Name of the DNS AAAA Record. Changing this forces a new resource to be created.
- `ttl` (Required) Time To Live (TTL) of the DNS record in seconds.
- `records` (Optional) List of IPv6 addresses for this AAAA record. Must be specified if `target_resource_id` is not specified.
- `target_resource_id` (Optional) The ID of the target Azure resource to which this record should point. Must be specified if `records` is not specified.
- `tags` (Optional) A map of tags to assign to the record.

Type:

```hcl
list(object({
    name               = string
    ttl                = number
    records            = optional(list(string))
    target_resource_id = optional(string)
    tags               = optional(map(string), null)
  }))
```

Default: `[]`

### <a name="input_cname_records"></a> [cname\_records](#input\_cname\_records)

Description: (Optional) A list of objects where each object contains information to create a `CNAME` record.

- `name` (Required) Name of the DNS CNAME Record. Changing this forces a new resource to be created.
- `ttl` (Required) Time To Live (TTL) of the DNS record in seconds.
- `record` (Optional) The target of the CNAME.
- `target_resource_id` (Optional) The ID of the target Azure resource to which this record should point. Must be specified if `record` is not specified.
- `tags` (Optional) A map of tags to assign to the record.

Type:

```hcl
list(object({
    name               = string
    ttl                = number
    record             = string
    target_resource_id = optional(string)
    tags               = optional(map(string), null)
  }))
```

Default: `[]`

### <a name="input_mx_records"></a> [mx\_records](#input\_mx\_records)

Description: (Optional) A list of objects where each object contains information to create an `MX` record.

- `name` (Optional) Name of the DNS MX Record. Defaults to `@` (root). Changing this forces a new resource to be created.
- `ttl` (Required) Time To Live (TTL) of the DNS record in seconds.
- `records` (Required) A list of objects that make up the MX record. Each object supports 2 fields:
    - `preference` (Required) Number representing the "preference” value of the MX records. Lower preference value takes priority.
    - `exchange` (Required) The mail server responsible for the domain of this MX record.
- `tags` (Optional) A map of tags to assign to the record.

Type:

```hcl
list(object({
    name = optional(string, "@")
    ttl  = number
    records = list(object({
      preference = number
      exchange   = string
    }))
    tags = optional(map(string), null)
  }))
```

Default: `[]`

### <a name="input_ns_records"></a> [ns\_records](#input\_ns\_records)

Description: (Optional) A list of objects where each object contains information to create an `NS` record.

- `name` (Required) Name of the DNS NS Record. Changing this forces a new resource to be created.
- `ttl` (Required) Time To Live (TTL) of the DNS record in seconds.
- `records` (Required) A list of values that make up the NS record. Each value is the FQDN of a nameserver, ending with period (e.g. "ns1-06.azure-dns.com.").
- `tags` (Optional) A map of tags to assign to the record.

Type:

```hcl
list(object({
    name    = string
    ttl     = number
    records = list(string)
    tags    = optional(map(string), null)
  }))
```

Default: `[]`

### <a name="input_ptr_records"></a> [ptr\_records](#input\_ptr\_records)

Description: (Optional) A list of objects where each object contains information to create a `PTR` record.

- `name` (Required) Name of the DNS PTR Record. Changing this forces a new resource to be created.
- `ttl` (Required) Time To Live (TTL) of the DNS record in seconds.
- `records` (Required) A list of values that make up the PTR record. Each value is a FQDN.
- `tags` (Optional) A map of tags to assign to the record.

Type:

```hcl
list(object({
    name    = string
    ttl     = number
    records = list(string)
    tags    = optional(map(string), null)
  }))
```

Default: `[]`

### <a name="input_srv_records"></a> [srv\_records](#input\_srv\_records)

Description: (Optional) A list of objects where each object contains information to create a `SRV` record.

- `name` (Optional) Name of the DNS SRV Record. Defaults to `@` (root). Changing this forces a new resource to be created.
- `ttl` (Required) Time To Live (TTL) of the DNS record in seconds.
- `records` (Required) A list of objects that make up the SRV record. Each object supports 4 fields:
    - `priority` (Required) Number representing the "priority" value of the SRV record. Lower priority value takes precedence.
    - `weight` (Required) Number representing the "weight" value of the SRV record. Higher weight value is preferred.
    - `port` (Required) The port on which the service is running.
    - `target` (Required) The hostname of the target host.
- `tags` (Optional) A map of tags to assign to the record.

Type:

```hcl
list(object({
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
```

Default: `[]`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: (Optional) Tags on this DNS Zone.

Type: `map(string)`

Default: `{}`

### <a name="input_txt_records"></a> [txt\_records](#input\_txt\_records)

Description: (Optional) A list of objects where each object contains information to create a `TXT` record.

- `name` (Required) Name of the DNS TXT Record. Changing this forces a new resource to be created.
- `ttl` (Required) Time To Live (TTL) of the DNS record in seconds.
- `records` (Required) A list of values that make up the TXT record.
- `tags` (Optional) A map of tags to assign to the record.

Type:

```hcl
list(object({
    name    = string
    ttl     = number
    records = list(string)
    tags    = optional(map(string), null)
  }))
```

Default: `[]`

## Outputs

The following outputs are exported:

### <a name="output_a_record_outputs"></a> [a\_record\_outputs](#output\_a\_record\_outputs)

Description: The a record output

### <a name="output_cname_record_outputs"></a> [cname\_record\_outputs](#output\_cname\_record\_outputs)

Description: The cname record output

### <a name="output_id"></a> [id](#output\_id)

Description: Azure resource id of DNS Zone

### <a name="output_max_number_of_record_sets"></a> [max\_number\_of\_record\_sets](#output\_max\_number\_of\_record\_sets)

Description: Maximum number of Records in Zone output

### <a name="output_mx_record_outputs"></a> [mx\_record\_outputs](#output\_mx\_record\_outputs)

Description: The mx record output

### <a name="output_name"></a> [name](#output\_name)

Description: The name of the DNS Zone

### <a name="output_name_servers"></a> [name\_servers](#output\_name\_servers)

Description: List of values that make up NS Record for Zone

### <a name="output_ns_record_outputs"></a> [ns\_record\_outputs](#output\_ns\_record\_outputs)

Description: The ns record output

### <a name="output_number_of_record_sets"></a> [number\_of\_record\_sets](#output\_number\_of\_record\_sets)

Description: Number of records in DNS Zone

### <a name="output_ptr_record_outputs"></a> [ptr\_record\_outputs](#output\_ptr\_record\_outputs)

Description: The ptr record output

### <a name="output_srv_record_outputs"></a> [srv\_record\_outputs](#output\_srv\_record\_outputs)

Description: The srv record output

### <a name="output_txt_record_outputs"></a> [txt\_record\_outputs](#output\_txt\_record\_outputs)

Description: The txt record output
<!-- END_TF_DOCS -->