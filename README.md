# Solution Description
This solution creates a resource group, virtual network, public Ip and Firewall on Azure with terraform codes.

# References:
* [Azure Firewall](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall)
* [Azure Firewall Networking rule collection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_network_rule_collection)
* [Azure Firewall NAT rule collection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_nat_rule_collection)
* [Azure Firewall Application rule collection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_application_rule_collection)
* [Dynamic blocks](https://www.terraform.io/language/expressions/dynamic-blocks)

# Notes
Change variable values under /tf/terraform.tfvars file as needed. 

# Usage
To trigger a CI build in Github Actions, submit a PR to the dev/feature branch.

To trigger terratest in the local environment:
```bash
$ cd test
$ make azdo-agent-test
```

To deploy to an Azure tenant:
```bash
$ make azdo-agent
```

To destroy the infra in the Azure tenant:
```bash
$ cd test
$ make destroy
```

To cleanup the TF configuration files in your local dev env:
```bash
$ cd test
$ make clean
```

---------------



<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.98.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.99.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_firewall.firewall](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall) | resource |
| [azurerm_firewall_application_rule_collection.application_rule_collection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_application_rule_collection) | resource |
| [azurerm_firewall_nat_rule_collection.nat_rule_collection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_nat_rule_collection) | resource |
| [azurerm_firewall_network_rule_collection.network_rule_collection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_network_rule_collection) | resource |
| [azurerm_public_ip.firewall_pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_rule_collections"></a> [application\_rule\_collections](#input\_application\_rule\_collections) | Create an application rule collection | <pre>list(object({<br>    name     = string,<br>    priority = number,<br>    action   = string,<br>    rules = list(object({<br>      name             = string,<br>      source_addresses = list(string),<br>      source_ip_groups = list(string),<br>      target_fqdns     = list(string),<br>      protocols = list(object({<br>        port = string,<br>        type = string<br>      }))<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_firewall_name"></a> [firewall\_name](#input\_firewall\_name) | The firewall name | `string` | n/a | yes |
| <a name="input_firewall_pip_name"></a> [firewall\_pip\_name](#input\_firewall\_pip\_name) | The public Ip name | `string` | n/a | yes |
| <a name="input_firewall_subnet_id"></a> [firewall\_subnet\_id](#input\_firewall\_subnet\_id) | The firewall subnet id | `string` | n/a | yes |
| <a name="input_nat_rule_collections"></a> [nat\_rule\_collections](#input\_nat\_rule\_collections) | Create a Nat rule collection | <pre>list(object({<br>    name     = string,<br>    priority = number,<br>    action   = string,<br>    rules = list(object({<br>      name               = string,<br>      source_addresses   = list(string),<br>      source_ip_groups   = list(string),<br>      destination_ports  = list(string),<br>      translated_port    = number,<br>      translated_address = string,<br>      protocols          = list(string)<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_network_rule_collections"></a> [network\_rule\_collections](#input\_network\_rule\_collections) | Create a network rule collection | <pre>list(object({<br>    name     = string,<br>    priority = number,<br>    action   = string,<br>    rules = list(object({<br>      name                  = string,<br>      source_addresses      = list(string),<br>      source_ip_groups      = list(string),<br>      destination_ports     = list(string),<br>      destination_addresses = list(string),<br>      destination_ip_groups = list(string),<br>      destination_fqdns     = list(string),<br>      protocols             = list(string)<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | A naming prefix to be used in the creation of unique names for Azure resources. | `list(string)` | `[]` | no |
| <a name="input_public_ip_sku"></a> [public\_ip\_sku](#input\_public\_ip\_sku) | The pricing and performance sku to create the Azure Firewalls public IP address to. | `string` | `"Standard"` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | A naming suffix to be used in the creation of unique names for Azure resources. | `list(string)` | `[]` | no |
| <a name="input_virtual_network"></a> [virtual\_network](#input\_virtual\_network) | The Virtual Network in which the AzureFirewallSubnet exists within. | <pre>object({<br>    name                = string<br>    resource_group_name = string<br>    location            = string<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firewall"></a> [firewall](#output\_firewall) | The ID of the Azure Firewall. |
| <a name="output_firewall_public_ip"></a> [firewall\_public\_ip](#output\_firewall\_public\_ip) | The Private IP address of the Azure Firewall. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->