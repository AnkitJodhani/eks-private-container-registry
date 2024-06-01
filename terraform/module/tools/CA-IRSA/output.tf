output "CLUSTER_AUTOSCALAR_ROLE_ARN" {
    value = aws_iam_role.clusterAutoscalar-role.arn
}

output "HELM_CLUSTER_AUTOSCALAR" {
  value = helm_release.helm-clusterAutoscalar-driver.metadata
}
