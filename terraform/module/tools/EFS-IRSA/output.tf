output "EFS_CSI_DRIVER_ROLE_ARN" {
    value = aws_iam_role.efs-csi-role.arn
}

# output "HELM_EFS_CSI" {
#   value = helm_release.helm-efs-csi-driver.metadata
# }

output "AWS_EFS_CSI_DRIVER_ARN" {
  value = aws_eks_addon.aws-efs-csi-driver.arn
}