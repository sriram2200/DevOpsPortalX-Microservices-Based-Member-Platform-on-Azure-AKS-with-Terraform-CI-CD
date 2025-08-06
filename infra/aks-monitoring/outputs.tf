


output "grafana_dashboard_url" {
  value = "http://${helm_release.grafana.name}.monitoring.svc.cluster.local"
}

output "grafana_admin_password" {
  value = "SuperSecurePassword"
  sensitive = true
}