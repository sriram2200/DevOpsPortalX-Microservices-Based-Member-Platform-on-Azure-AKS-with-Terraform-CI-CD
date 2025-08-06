resource "azurerm_kubernetes_cluster" "azaks" {
  name                = var.aksname
  location            = var.rglocation
  resource_group_name = var.rgname
  dns_prefix          = var.aksdns

  default_node_pool {
    name       = "akspool"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.envn
  }
}

#aks nodepool

resource "azurerm_kubernetes_cluster_node_pool" "azakspool" {
  name                  = var.aksnpname
  kubernetes_cluster_id = azurerm_kubernetes_cluster.azaks.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 1

  tags = {
    Environment = var.envn
  }
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.azaks.kubelet_identity[0].object_id
  role_definition_name             = "acrpull"
  scope                            = var.acr_id
  depends_on = [ azurerm_kubernetes_cluster.azaks ]
}


