# Default

Deploys a private dns zone called `privatelink.blob.core.windows.net`

```hcl
module "resource_group" {
  source   = "app.terraform.io/wcbbc/resource_group/azurerm"
  version  = "~> 0.0.3"
  name     = "cc-dv-example-rg"
  location = "canadacentral"
}

module "blob_private_link_dns_zone" {
  source  = "app.terraform.io/wcbbc/private_dns_zone/azurerm"
  version = "~> 0.0.1"

  name                = "privatelink.blob.core.windows.net"
  resource_group_name = module.resource_group.name
}

```
