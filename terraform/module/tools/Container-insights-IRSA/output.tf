output "CONTAINER_INSIGHT_DRIVER_ROLE_ARN" {
    value = aws_iam_role.container-insight-role.arn
}

output "AWS_CONTAINER_INSIGHT_DRIVER_ARN" {
  value = aws_eks_addon.aws-container-insight-driver.arn
}

