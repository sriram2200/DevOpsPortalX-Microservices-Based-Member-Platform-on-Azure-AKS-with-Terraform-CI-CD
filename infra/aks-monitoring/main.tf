terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "4.35.0"
    }
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  namespace  = "monitoring"
  create_namespace = true

  values = [<<EOF
    alertmanager:
      enabled: true
    server:
      persistentVolume:
        enabled: true
  EOF
  ]
}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = "monitoring"
  depends_on = [helm_release.prometheus]
  
  values = [<<EOF
    persistence:
      enabled: true
    adminPassword: "${var.grafana_admin_password}"
    service:
      type: LoadBalancer
  EOF
  ]
}


resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  namespace  = "ingress-nginx"
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  version    = "4.9.0"

  create_namespace = true

  values = [
    yamlencode({
      controller = {
        replicaCount = 1
        service = {
          type = "LoadBalancer"
        }
      }
    })
  ]
}

resource "kubernetes_ingress_v1" "appingress" {
  metadata {
    name      = "app-ingress"
    namespace = "default"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }

  spec {
    rule {

      http {
        path {
          path     = "/"
          path_type = "Prefix"

          backend {
            service {
              name = "python"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

