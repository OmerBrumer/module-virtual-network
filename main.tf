/**
* # Virtual Network and Diagnostic Setting module
* There's an option to add ddos_protection plan and associate subnets  
*/

resource "azurerm_network_ddos_protection_plan" "ddos" {
  count = var.create_ddos_plan ? 1 : 0

  name                = "${var.vnet_name}-ddos"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.vnet_address_space
  dns_servers         = var.dns_servers

  dynamic "ddos_protection_plan" {
    for_each = var.create_ddos_plan ? [{}] : []

    content {
      id     = azurerm_network_ddos_protection_plan.ddos[0].id
      enable = true
    }
  }

  lifecycle {
    ignore_changes = [tags]
  }

  depends_on = [
    azurerm_network_ddos_protection_plan.ddos
  ]
}

module "subnet" {
  for_each = var.subnets
  source   = "git::https://github.com/OmerBrumer/module-subnet.git"

  virtual_network_name      = azurerm_virtual_network.vnet.name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  subnet_name               = each.key
  subnet_address_prefixes   = each.value.subnet_address_prefixes
  route_table_id            = each.value.route_table_id
  network_security_group_id = each.value.network_security_group_id

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

module "diagnostic_settings" {
  source = "git::https://github.com/OmerBrumer/module-diagnostic-setting.git"

  diagonstic_setting_name    = "${azurerm_virtual_network.vnet.name}-diagnostic-setting"
  log_analytics_workspace_id = var.log_analytics_workspace_id
  target_resource_id         = azurerm_virtual_network.vnet.id
}