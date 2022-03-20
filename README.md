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