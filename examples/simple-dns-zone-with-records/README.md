# Simple DNS Zone with records

Deploy a DNS Zone with A, CNAME, and TXT records.

```hcl
locals {

  zone_name           = "mynewzone.worksafebc.com"
  resource_group_name = "MG-PR-AzureDNS-RG"

  tags = {
    env = "development"
  }

  a_records = [
    {
      name    = "api"
      ttl     = 3600
      records = ["10.8.188.10", "10.8.188.11"]
      tags = {
        dev = "alice"
      }
    },
    {
      name    = "docs"
      ttl     = 3600
      records = ["10.8.188.20", "10.8.188.21"]
      tags = {
        dev = "bob"
      }
    },
  ]

  cname_records = [
    {
      name   = "app_one"
      ttl    = 3600
      record = "pink-pony.contoso.com"
      tags = {
        dev = "charles"
      }
    },
    {
      name   = "app_two"
      ttl    = 3600
      record = "green-badger.contoso.com"
      tags = {
        dev = "donna"
      }
    },
  ]

  mx_records = [
    {
      name = "mail"
      ttl  = 3600
      records = [
        {
          preference = 1
          exchange   = "mail1.example.com"
        },
        {
          preference = 2
          exchange   = "mail2.example.com"
        }
      ]
      tags = {
        dev = "debra"
      }
    },
  ]


  txt_records = [
    {
      name    = "asuid.app_one"
      ttl     = 3600
      records = ["google-site-authenticator", "C1C74073...EB9"]
      tags = {
        dev = "edgar"
      }
    },
    {
      name    = "asuid.app_two"
      ttl     = 3600
      records = ["google-site-authenticator", "C1C74073...EB9"]
      tags = {
        dev = "edgar"
      }
    },
  ]

  srv_records = [
    {
      name = "srv_record_a"
      ttl  = 3600
      records = [
        {
          priority = 10
          weight   = 5
          port     = 5060
          target   = "sipserver1.example.com"
        },
        {
          priority = 20
          weight   = 10
          port     = 5060
          target   = "sipserver2.example.com"
        }
      ]
      tags = {
        dev = "felicia"
      }
    },
    {
      name = "srv_record_b"
      ttl  = 3600
      records = [
        {
          priority = 2
          weight   = 3
          port     = 48001
          target   = "snmp1.example.com"
        },
        {
          priority = 4
          weight   = 6
          port     = 48001
          target   = "snmp2.example.com"
        }
      ]
      tags = {
        dev = "garry"
      }
    },
  ]

}

module "dns_zone" {
  source              = "app.terraform.io/wcbbc/dns_zone/azurerm"
  version             = "~> 0.0.3"
  resource_group_name = local.resource_group_name
  name                = local.zone_name
  tags                = local.tags
  a_records           = local.a_records
  cname_records       = local.cname_records
  mx_records          = local.mx_records
  txt_records         = local.txt_records
  srv_records         = local.srv_records
}
```
