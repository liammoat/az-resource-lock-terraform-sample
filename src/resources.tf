resource "azurerm_resource_group" "default" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_management_lock" "rg" {
  name       = "${azurerm_resource_group.default.name}-ReadOnly"
  scope      = azurerm_resource_group.default.id
  lock_level = "ReadOnly"
  notes      = "This Resource Group is Read-Only"
}

resource "azurerm_virtual_network" "default" {
  name                = "${var.prefix}-vnet"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_management_lock" "vnet" {
  name       = "${azurerm_virtual_network.default.name}-CanNotDelete"
  scope      = azurerm_virtual_network.default.id
  lock_level = "CanNotDelete"
  notes      = "Locked because it's needed by a third-party"
}