<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.9)

- <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) (~> 2.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 4.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (~> 4.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) (resource)
- [azurerm_private_dns_zone_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_name"></a> [name](#input\_name)

Description: (Required) The name of the Private DNS Zone. Must be a valid domain name. Changing this forces a new resource to be created.

Type: `string`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_tags"></a> [tags](#input\_tags)

Description: (Optional) A map of tags to assign to the private dns zone.

Type: `map(string)`

Default: `{}`

### <a name="input_virtual_networks"></a> [virtual\_networks](#input\_virtual\_networks)

Description: (Optional) A list of virtual networks to link to the private dns zone

- `id` - (Required) The virtual network resource id to link
- `registration_enabled` - (Optional) Is auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled? Defaults to `false`.

Type:

```hcl
list(object({
    id                   = string
    registration_enabled = optional(bool, false)
  }))
```

Default: `[]`

## Outputs

The following outputs are exported:

### <a name="output_id"></a> [id](#output\_id)

Description: The resource id of the private dns zone

### <a name="output_name"></a> [name](#output\_name)

Description: The name of the private dns zone
<!-- END_TF_DOCS -->