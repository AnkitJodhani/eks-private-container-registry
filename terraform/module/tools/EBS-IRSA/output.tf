output "EBS_CSI_DRIVER_ROLE_ARN" {
    value = aws_iam_role.ebs-csi-role.arn
}

# output "HELM_EBS_CSI" {
#   value = helm_release.helm-ebs-csi-driver.metadata
# }

output "AWS_EBS_CSI_DRIVER_ARN" {
  value = aws_eks_addon.aws-ebs-csi-driver.arn
}

