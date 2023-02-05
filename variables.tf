variable "resource_group_name" {
  description = "(Required)A container that holds related resources for an Azure solution."
  type        = string
}

variable "location" {
  description = "(Required)The location to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'."
  type        = string
}

variable "vnet_name" {
  description = "(Required)The name of the virtual network."
  type        = string
}

variable "vnet_address_space" {
  description = "(Required)The address space to be used for the Azure virtual network."
  type        = list(string)
}

variable "log_analytics_workspace_id" {
  description = "(Required)Specifies the id of the Log Analytics Workspace."
  type        = string
}

variable "subnets" {
  description = "(Optional)For each subnet, create an object that contain fields."
  type = map(object({
    subnet_address_prefixes   = list(string)
    route_table_id            = optional(string)
    network_security_group_id = optional(string)
    delegation = optional(object({
      name = string
    }))
  }))
  default = {}
}

variable "create_ddos_plan" {
  description = "(Optional)Create an ddos plan - Default is false."
  type        = bool
  default     = false
}

variable "dns_servers" {
  description = "(Optional)List of dns servers to use for virtual network."
  type        = list(string)
  default     = []
}