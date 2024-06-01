output "LBC_ROLE_ARN" {
    value = aws_iam_role.lbc-role.arn
}

output "HELM_LBC" {
  value = helm_release.helm-lbc-controller.metadata
}
