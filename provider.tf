terraform {
  required_version = ">= 0.14"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0, <4.0.0"
    }
    # random = {
    #   source  = "hashicorp/random"
    #   version = ">= 2.88.1, < 3.0.0"
    # }
  }
}


# provider "azurerm" {
# features {}
# subscription_id = ""
# }