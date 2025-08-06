data "terraform_remote_state" "azaks" {
  backend = "azurerm"
  config = {
    resource_group_name  = "infra"
    storage_account_name = "infrastorage22"
    container_name       = "infra-cont"
    key                  = "terraform.tfstate"
  }
}

locals {
  kube_config = data.terraform_remote_state.azaks.outputs.kube_config
}