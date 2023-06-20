variable "location" {
  type        = string
  description = "Location used to deploy the resources"
  default     = "westus2"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
  default = {
    environment = "test"
    managed_by  = "terratest"
  }
}

variable "firewall_policy_id" {
  type        = string
  description = "The ID of Firewall policy to associate with the Firewall"
  default     = "fw-policy"
}