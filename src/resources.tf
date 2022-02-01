locals {
  prefix = "${var.prefix}-${var.env}"
  tags = {
    environment = var.env
  }
}

resource "azurerm_resource_group" "default" {
  name     = "${local.prefix}-rg"
  location = var.location
  tags     = local.tags
}

resource "azurerm_management_lock" "rg" {
  name       = "${azurerm_resource_group.default.name}-ReadOnly"
  scope      = azurerm_resource_group.default.id
  lock_level = "ReadOnly"
  notes      = "This Resource Group is Read-Only"
  count      = var.enable_locks ? 1 : 0
}

resource "azurerm_virtual_network" "default" {
  name                = "${local.prefix}-vnet"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  tags                = local.tags

  address_space = ["10.0.0.0/16"]
}

resource "azurerm_management_lock" "vnet" {
  name       = "${azurerm_virtual_network.default.name}-CanNotDelete"
  scope      = azurerm_virtual_network.default.id
  lock_level = "CanNotDelete"
  notes      = "Locked because it's needed by a third-party"
  count      = var.enable_locks ? 1 : 0
}
