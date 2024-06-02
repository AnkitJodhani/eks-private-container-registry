# ⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉ 📢 Kuberntes outputs ⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉
output "CLUSTER_ENDPOINT" {
  value = module.EKS.CLUSTER_ENDPOINT
}

output "KUBECONFIG_CERTIFICATE_AUTHORITY_DATA" {
  value = module.EKS.KUBECONFIG_CERTIFICATE_AUTHORITY_DATA
}

output "CLUSTER_ARN" {
  value = module.EKS.CLUSTER_ARN
}

output "CLUSTER_ID" {
  value = module.EKS.CLUSTER_ID
}
output "CLUSTER_SECURITY_GROUP_ID" {
  value = module.EKS.CLUSTER_SECURITY_GROUP_ID
}
output "CLUSTER_OIDC_ISSUER_URL" {
  value = module.EKS.CLUSTER_OIDC_ISSUER_URL
}


/*
# ⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉ 📢 Public NodeGroup output ⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉
# Public NODEGROUP OUTPUT - Uncomment below output if you have PUBLIC NODEGROUP

output "NODEGROUP_PUBLIC_ID" {
  value = module.EKS.NODEGROUP_PUBLIC_ID
}

output "NODEGROUP_PUBLIC_STATUS" {
  value = module.EKS.NODEGROUP_PUBLIC_STATUS

}
output "NODEGROUP_PUBLIC_VERSION" {
    value = module.EKS.NODEGROUP_PUBLIC_VERSION
}
output "NODEGROUP_PUBLIC_ARN" {

  value = module.EKS.NODEGROUP_PUBLIC_ARN
}

*/

# Private NODEGROUP OUTPUT
# ⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉ 📢 Private NodeGroup output ⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉
output "NODEGROUP_PRIVATE_ID" {
  value = module.EKS.NODEGROUP_PRIVATE_ID
}

output "NODEGROUP_PRIVATE_STATUS" {
  value = module.EKS.NODEGROUP_PRIVATE_STATUS
}
output "NODEGROUP_PRIVATE_VERSION" {
  value = module.EKS.NODEGROUP_PRIVATE_VERSION
}
output "NODEGROUP_PRIVATE_ARN" {
  value = module.EKS.NODEGROUP_PRIVATE_ARN
}

output "ENV" {
  value = var.ENV
}

output "EKS_OIDC_CONNECT_PROVIDER_ARN" {
  value = module.EKS.EKS_OIDC_CONNECT_PROVIDER_ARN
}
output "EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT" {
  value = module.EKS.EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT
}

# ⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉ 📢 Tools IRSA output ⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉⇉
/*
# Metrics server
output "HELM_METRICS_SERVER" {
  value = module.METRICS_SERVER.HELM_METRICS_SERVER
}
*/
/*
# EBS CSI Driver
output "AWS_EBS_DRIVER_ARN" {
  value = module.IAM_EBS_CSI.AWS_EBS_CSI_DRIVER_ARN
}
*/

# EFS CSI Driver
output "AWS_EFS_DRIVER_ARN" {
  value = module.IAM_EFS_CSI.AWS_EFS_CSI_DRIVER_ARN
}

# AWS LBC
output "HELM_LBC" {
  value = module.IAM_LBC.HELM_LBC
}

# External DNS
output "HELM_EXTERNALDNS" {
  value = module.IAM_EXTERNALDNS.HELM_EXTERNALDNS
}
/*
# Cluster Autoscaler
output "HELM_CLUSTER_AUTOSCALAR" {
  value = module.IAM_CLUSTER_AUTOSCALAR.HELM_CLUSTER_AUTOSCALAR
}
*/
/*
# Container Insight
output "AWS_CONTAINER_INSIGHT_DRIVER_ARN" {
  value = module.IAM_CONTAINER_INSIGHT.AWS_CONTAINER_INSIGHT_DRIVER_ARN
}
*/