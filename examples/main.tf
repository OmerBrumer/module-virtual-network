module "vnet" {
  source = "./modules/network/vnet"

  vnet_name           = "brumer-final-terraform-hub-vnet"
  resource_group_name = "brumer-final-terraform-hub-rg"
  location            = "West Europe"
  vnet_address_space  = "10.0.0.0/16"

  subnets = {
    "EndpointSubnet" = {
      subnet_address_prefixes   = ["10.0.4.0/26"]
      route_table_id            = "/subscriptions/d94fe338-52d8-4a44-acd4-4f8301adf2cf/resourceGroups/brumer-final-terraform-hub-rg/providers/Microsoft.Network/routeTables/brumer-final-terraform-hub-firewall-routetable"
      network_security_group_id = "/subscriptions/d94fe338-52d8-4a44-acd4-4f8301adf2cf/resourceGroups/brumer-final-terraform-hub-rg/providers/Microsoft.Network/networkSecurityGroups/brumer-final-terraform-hub-nsg"
    }
  }

  log_analytics_workspace_id = "/subscriptions/d94fe338-52d8-4a44-acd4-4f8301adf2cf/resourcegroups/brumer-final-terraform-hub-rg/providers/microsoft.operationalinsights/workspaces/brumer-final-terraform-hub-log-analytics"
}