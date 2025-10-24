variable "name" {
  description = "(Required) The name of the Private DNS Zone. Must be a valid domain name. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "tags" {
  description = "(Optional) A map of tags to assign to the private dns zone."
  type        = map(string)
  default     = {}
  validation {
    condition = alltrue([
      for k in keys(var.tags) : lower(k) != "tfc-module"
    ])
    error_message = "'tfc-module' is a reserved tag and must not be set by module consumers."
  }
}

variable "virtual_networks" {
  description = <<-EOT
    (Optional) A list of virtual networks to link to the private dns zone

    - `id` - (Required) The virtual network resource id to link
    - `registration_enabled` - (Optional) Is auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled? Defaults to `false`.
  EOT
  type = list(object({
    id                   = string
    registration_enabled = optional(bool, false)
  }))
  default = []
}
