
resource "aws_iam_role" "vpc-cni-role" {
  name = var.ROLE_VPC_CNI

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
              "${var.EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT}:aud" : "sts.amazonaws.com",
              "${var.EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT}:sub" : "system:serviceaccount:${var.VPC_CNI_NAMESPACE}:${var.VPC_CNI_SA_NAME}"
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

resource "aws_iam_role_policy_attachment" "vpc-cni-policy-attachment" {
  role       = aws_iam_role.vpc-cni-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}


resource "aws_eks_addon" "aws-vpc-cni-addon" {
  cluster_name             = var.CLUSTER_ID
  addon_name               = "vpc-cni"
  service_account_role_arn = aws_iam_role.vpc-cni-role.arn
  configuration_values = jsonencode({
    enableNetworkPolicy : "true"
  })
}
