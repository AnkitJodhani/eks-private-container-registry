
resource "aws_iam_role" "container-insight-role" {
  name = var.ROLE_CONTAINER_INSIGHT_DRIVER

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
              "${var.EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT}:sub" : "system:serviceaccount:${var.CONTAINER_INSIGHT_DRIVER_NAMESPACE}:${var.CONTAINER_INSIGHT_DRIVER_SA_NAME}"
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

resource "aws_iam_role_policy_attachment" "container-insight-policy-attachment-01" {
  role       = aws_iam_role.container-insight-role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy_attachment" "container-insight-policy-attachment-02" {
  role       = aws_iam_role.container-insight-role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSXrayWriteOnlyAccess" // Taken from AWS Doc - List of EKS-Add-on
}


resource "aws_eks_addon" "aws-container-insight-driver" {
  cluster_name = var.CLUSTER_ID
  addon_name   = "amazon-cloudwatch-observability"
  service_account_role_arn  = "${aws_iam_role.container-insight-role.arn}"
}