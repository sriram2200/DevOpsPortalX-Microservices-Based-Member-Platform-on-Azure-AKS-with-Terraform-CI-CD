 terraform {
  backend "azurerm" {
    resource_group_name  = "infra"
    storage_account_name = "infrastorage22"
    container_name       = "infra-cont"
    key                  = "terraform.tfstate"
  }
 }