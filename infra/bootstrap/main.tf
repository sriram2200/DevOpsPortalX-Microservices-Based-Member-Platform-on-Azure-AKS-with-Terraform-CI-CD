terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.35.0"
    }
  }
}

provider "azurerm" {
    features {}
}


resource "azurerm_storage_account" "storageacc" {
  name                     = "infrastorage22"
  resource_group_name      = var.rgname
  location                 = var.rglocation
  account_tier             = "Standard"
  account_replication_type = "LRS"
  depends_on = [ azurerm_resource_group.demo ]
  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = var.envn
  }
}

##Role Assignments for SA

resource "azurerm_role_assignment" "sa-role" {
  scope                = azurerm_resource_group.demo.id
  role_definition_name = "Owner"
  principal_id = azurerm_storage_account.storageacc.identity[0].principal_id  
  depends_on = [ azurerm_storage_account.storageacc ]
}


##create a Blob Container

resource "azurerm_storage_container" "sa-blob" {
  name                  = "infra-cont"
  storage_account_id    = azurerm_storage_account.storageacc.id
  container_access_type = "blob"
  depends_on = [ azurerm_role_assignment.sa-role ]
}

resource "azurerm_role_assignment" "blob-role" {
  scope                = azurerm_storage_account.storageacc.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id = var.spid
  depends_on = [ azurerm_storage_container.sa-blob ]
}


resource "azurerm_resource_group" "demo" {
  name     = var.rgname
  location = var.rglocation
}