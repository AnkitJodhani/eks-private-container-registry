output "VPC_CNI_ROLE_ARN" {
    value = aws_iam_role.vpc-cni-role.arn
}

output "VPC_CNI_ARN" {
  value = aws_eks_addon.aws-vpc-cni-addon.arn
}

