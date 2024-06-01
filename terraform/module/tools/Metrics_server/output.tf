output "HELM_METRICS_SERVER" {
  value = helm_release.helm-metrics-server-driver.metadata
}