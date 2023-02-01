<!-- BEGIN_TF_DOCS -->

# Virtual Network and Diagnostic Setting module
There's an option to add ddos\_protection plan and associate subnets  

## Examples
```hcl
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
```

#### Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Id of virtual network. |
| <a name="output_name"></a> [name](#output\_name) | Name of virtual network. |
| <a name="output_object"></a> [object](#output\_object) | Object of virtual network. |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | IDs of all subnets. |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | (Required)The location to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | (Required)Specifies the id of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required)A container that holds related resources for an Azure solution | `string` | n/a | yes |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | (Required)The address space to be used for the Azure virtual network. | `list(string)` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | (Required)The name of the virtual network. | `string` | n/a | yes |
| <a name="input_create_ddos_plan"></a> [create\_ddos\_plan](#input\_create\_ddos\_plan) | (Optional)Create an ddos plan - Default is false. | `bool` | `false` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | (Optional)List of dns servers to use for virtual network. | `list(string)` | `[]` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | (Optional)For each subnet, create an object that contain fields. | <pre>map(object({<br>    subnet_address_prefixes   = list(string)<br>    route_table_id            = optional(string)<br>    network_security_group_id = optional(string)<br>    delegation = optional(object({<br>      name = string<br>    }))<br>  }))</pre> | `{}` | no |



# Authors
Originally created by Omer Brumer
<!-- END_TF_DOCS -->