#VNET outputs
output "id" {
  description = "Id of virtual network."
  value       = azurerm_virtual_network.vnet.id
}

output "name" {
  description = "Name of virtual network."
  value       = azurerm_virtual_network.vnet.name
}

output "object" {
  description = "Object of virtual network."
  value       = azurerm_virtual_network.vnet
}

#Subnet outputs
output "subnet_ids" {
  description = "IDs of all subnets."
  value = {
    for subnet in module.subnet :
    subnet.name => subnet.id
  }
}