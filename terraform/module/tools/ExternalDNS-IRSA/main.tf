
resource "aws_iam_policy" "externalDNS-policy" {
  name        = "${var.ROLE_AllowExternalDNSUpdates}-policy"
  path        = "/"
  description = "This policy will give enough permisson to IRSA so that it can talk to Route 53"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ChangeResourceRecordSets"
        ],
        "Resource" : [
          "arn:aws:route53:::hostedzone/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets",
          "route53:ListTagsForResource"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })
}


resource "aws_iam_role" "externalDNS-role" {
  name = var.ROLE_AllowExternalDNSUpdates

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Federated" : var.EKS_OIDC_CONNECT_PROVIDER_ARN
          },
          "Action" : "sts:AssumeRoleWithWebIdentity",
          "Condition" : {
            "StringEquals" : {
              "${var.EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT}:aud" : "sts.amazonaws.com"
            },
            "StringLike" : {
              "${var.EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT}:sub" : "system:serviceaccount:${var.EXTERNAL_DNS_NAMESPACE}:${var.EXTERNAL_DNS_SA_NAME}"
            }
          }
        }
      ]
    }
  )

  tags = {
    Name = var.CLUSTER_ID
    env  = var.ENV
  }
}

resource "aws_iam_role_policy_attachment" "externalDNS-policy-attachment" {
  role       = aws_iam_role.externalDNS-role.name
  policy_arn = aws_iam_policy.externalDNS-policy.arn
}

/*

There are 1 Ways to Deploy Driver

# 🔸 Helm

*/

# 🔸 Helm
# Lets install ExternalDNS Driver through helm provider

resource "helm_release" "helm-externalDNS" {
  depends_on = [ aws_iam_role_policy_attachment.externalDNS-policy-attachment  ]
  name       = "external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns"
  chart      = "external-dns"
  namespace  = var.EXTERNAL_DNS_NAMESPACE

  set {
    name  = "namespaced"
    value = "false"
  }
  set {
    name  = "serviceAccount.create"
    value = "true"
  }
  set {
    name  = "serviceAccount.name"
    value = var.EXTERNAL_DNS_SA_NAME
  }
  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "${aws_iam_role.externalDNS-role.arn}"
  }
}

