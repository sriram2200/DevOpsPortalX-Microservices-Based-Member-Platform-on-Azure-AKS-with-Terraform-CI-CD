resource "azurerm_container_registry" "acr" {
  name                = var.acrname
  resource_group_name = var.rgname
  location            = var.rglocation
  sku                 = "Basic"
  identity {
    type = "SystemAssigned"
  }
  tags = {
    Environment = var.envn
  }
}


