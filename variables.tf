#Required Variables
variable "location" {
  type        = string
  description = "The Location where RG is created"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource group"
}

variable "firewall_subnet_id" {
  type        = string
  description = "The firewall subnet id"
}

variable "firewall_pip_name" {
  type        = string
  description = "The public Ip name"
}

variable "firewall_name" {
  type        = string
  description = "The firewall name"
}

variable "sku_name" {
  type        = string
  description = "Sku name of the Firewall"
}

variable "sku_tier" {
  type        = string
  description = "Sku tier of the Firewall"
}

#Optional Variables
variable "prefix" {
  type        = list(string)
  description = "A naming prefix to be used in the creation of unique names for Azure resources."
  default     = []
}

variable "suffix" {
  type        = list(string)
  description = "A naming suffix to be used in the creation of unique names for Azure resources."
  default     = []
}

variable "public_ip_sku" {
  type        = string
  description = "The pricing and performance sku to create the Azure Firewalls public IP address to."
  default     = "Standard"
}

variable "network_rule_collections" {
  description = "Create a network rule collection"
  type = list(object({
    name     = string,
    priority = number,
    action   = string,
    rules = list(object({
      name                  = string,
      source_addresses      = list(string),
      source_ip_groups      = list(string),
      destination_ports     = list(string),
      destination_addresses = list(string),
      destination_ip_groups = list(string),
      destination_fqdns     = list(string),
      protocols             = list(string)
    }))
  }))
  default = null
}

variable "application_rule_collections" {
  description = "Create an application rule collection"
  type = list(object({
    name     = string,
    priority = number,
    action   = string,
    rules = list(object({
      name             = string,
      source_addresses = list(string),
      source_ip_groups = list(string),
      target_fqdns     = list(string),
      protocols = list(object({
        port = string,
        type = string
      }))
    }))
  }))
  default = null
}

variable "nat_rule_collections" {
  description = "Create a Nat rule collection"
  type = list(object({
    name     = string,
    priority = number,
    action   = string,
    rules = list(object({
      name               = string,
      source_addresses   = list(string),
      source_ip_groups   = list(string),
      destination_ports  = list(string),
      translated_port    = number,
      translated_address = string,
      protocols          = list(string)
    }))
  }))
  default = null
}

