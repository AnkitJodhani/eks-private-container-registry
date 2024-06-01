
/*

There are 1 Ways to Metrics servers  Driver

# 🔸 Helm

*/

# 🔸 Helm
# Lets install Metrics server  Driver through helm provider

resource "helm_release" "helm-metrics-server-driver" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = var.METRICS_SERVER_DRIVER_NAMESPACE
  version    = "3.12.0"
  set {
    name  = "serviceAccount.name"
    value = var.METRICS_SERVER_DRIVER_SA_NAME
  }
}

