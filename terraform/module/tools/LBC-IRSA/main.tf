# Getting the policy (JSON) content - took from documentation
data "http" "lbc-policy-json" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.7.0/docs/install/iam_policy.json"

  # Optional request headers
  request_headers = {
    Accept = "application/json"
  }
}


resource "aws_iam_policy" "lbc-policy" {
  name        = "${var.ROLE_LBC}-policy"
  path        = "/"
  description = "This policy will give enough permisson to IRSA so that it can talk to ELB Service"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  depends_on = [ data.http.lbc-policy-json ]
  policy = data.http.lbc-policy-json.response_body
}


resource "aws_iam_role" "lbc-role" {
  name = var.ROLE_LBC

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
              "${var.EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT}:sub" : "system:serviceaccount:${var.LBC_NAMESPACE}:${var.LBC_SA_NAME}"
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

resource "aws_iam_role_policy_attachment" "lbc-policy-attachment" {
  role       = aws_iam_role.lbc-role.name
  policy_arn = aws_iam_policy.lbc-policy.arn
}

/*

There are 1 Ways to Deploy Controller

# 🔸 Helm

*/

# 🔸 Helm
# Lets install AWS LBC Controller through helm provider


resource "helm_release" "helm-lbc-controller" {
  depends_on = [ aws_iam_role_policy_attachment.lbc-policy-attachment  ]
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = var.LBC_NAMESPACE

  set {
    name  = "clusterName"
    value = var.CLUSTER_ID
  }
  set {
    name  = "serviceAccount.create"
    value = "true"
  }
  set {
    name  = "serviceAccount.name"
    value = var.LBC_SA_NAME
  }
  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "${aws_iam_role.lbc-role.arn}"
  }
}

