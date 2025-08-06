resource "azurerm_virtual_network" "azvnet" {
  name                = var.vnetname
  location            = var.rglocation
  resource_group_name = var.rgname
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "azsubnet" {
  name                 = var.snetname
  resource_group_name  = var.rgname
  virtual_network_name = var.vnetname
  address_prefixes     = ["10.0.1.0/24"]
  depends_on = [ azurerm_virtual_network.azvnet ]
}