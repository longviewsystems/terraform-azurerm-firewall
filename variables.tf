# Read in from environment variables

variable "resource_group_name" {
  type        = string
  description = "Resource group name for networking."
}

variable "location" {
  type        = string
  description = "Location"
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
}

variable "vnet_name" {
  type        = string
  description = "name of the virtual network."
  default     = ""
}

variable "subnet_name" {
  type        = string
  description = "name of the subnet."
  default     = ""
}

variable "public_ip_name" {
  type        = string
  description = "name of the public Ip."
  default     = ""
}

variable "firewall_name" {
  type        = string
  description = "name of the firewall name."
  default     = ""
}

variable "address_spaces" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
}


variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  type        = list(string)
}
