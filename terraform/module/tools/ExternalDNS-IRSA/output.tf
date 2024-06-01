output "EXTERNAL_DNS_ROLE_ARN" {
    value = aws_iam_role.externalDNS-role.arn
}

output "HELM_EXTERNALDNS" {
  value = helm_release.helm-externalDNS.metadata
}


