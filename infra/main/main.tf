terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "4.35.0"
    }
  }
}
provider "azurerm" {
    features {}
}


#vnet
#subnet
module "network" {
  source = "./modules/network"
  rgname = var.rgname
  rglocation = var.rglocation
  vnetname = var.vnetname
  snetname = var.snetname
}


#aks cluster
#aks nodepool

module "aks" {
  source = "./modules/aks"
  envn = var.envn
  aksnpname = var.aksnpname
  aksname = var.aksname
  aksdns = var.aksdns
  rgname = var.rgname
  rglocation = var.rglocation
  acr_id = module.acr.acr_id
  depends_on = [ module.acr ]
}


module "acr" {
  source = "./modules/acr"
  envn = var.envn
  rglocation = var.rglocation
  rgname = var.rgname
  acrname = var.acrname
  
}



