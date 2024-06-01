output "EKS_MAIN_ROLE_ID" {
  value = aws_iam_role.eks-cluster-main.id
}
output "EKS_MAIN_ROLE_ARN" {
  value = aws_iam_role.eks-cluster-main.arn
}
output "EKS_MAIN_ROLE_NAME" {
  value = aws_iam_role.eks-cluster-main.name
}

output "EKS_MAIN_NODEGROUP_ROLE_ID" {
  value = aws_iam_role.eks-nodegroup-main.id
}
output "EKS_MAIN_NODEGROUP_ROLE_ARN" {
  value = aws_iam_role.eks-nodegroup-main.arn
}
output "EKS_MAIN_NODEGROUP_ROLE_NAME" {
  value = aws_iam_role.eks-nodegroup-main.name
}

