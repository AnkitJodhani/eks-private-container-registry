output "CLUSTER_ENDPOINT" {
  value = aws_eks_cluster.cluster.endpoint
}

output "KUBECONFIG_CERTIFICATE_AUTHORITY_DATA" {
  value = aws_eks_cluster.cluster.certificate_authority[0].data
}

output "CLUSTER_ARN" {
  value = aws_eks_cluster.cluster.arn

}

output "CLUSTER_ID" {
  value = aws_eks_cluster.cluster.id
}
output "CLUSTER_SECURITY_GROUP_ID" {
  value = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
}
output "CLUSTER_OIDC_ISSUER_URL" {
  value = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

/*
# Public NODEGROUP OUTPUT - Uncomment below output if you have PUBLIC NODEGROUP

output "NODEGROUP_PUBLIC_ID" {
  value = aws_eks_node_group.public-nodegroup.id
}

output "NODEGROUP_PUBLIC_STATUS" {
  value = aws_eks_node_group.public-nodegroup.status

}
output "NODEGROUP_PUBLIC_VERSION" {

  value = aws_eks_node_group.public-nodegroup.version
}
output "NODEGROUP_PUBLIC_ARN" {

  value = aws_eks_node_group.public-nodegroup.arn
}
*/


# Private NODEGROUP OUTPUT

output "NODEGROUP_PRIVATE_ID" {
  value = aws_eks_node_group.private-nodegroup.id
}

output "NODEGROUP_PRIVATE_STATUS" {
  value = aws_eks_node_group.private-nodegroup.status

}
output "NODEGROUP_PRIVATE_VERSION" {

  value = aws_eks_node_group.private-nodegroup.version
}
output "NODEGROUP_PRIVATE_ARN" {

  value = aws_eks_node_group.private-nodegroup.arn
}

output "EKS_OIDC_CONNECT_PROVIDER_ARN" {
  value = aws_iam_openid_connect_provider.eks-oidc.arn
}
output "EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT" {
  value = element(split("oidc-provider/",aws_iam_openid_connect_provider.eks-oidc.arn),1)
}