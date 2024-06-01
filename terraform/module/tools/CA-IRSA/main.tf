
resource "aws_iam_policy" "clusterAutoscalar-policy" {
  name        = "${var.ROLE_CLUSTER_AUTOSCALAR_DRIVER}-policy"
  path        = "/"
  description = "This policy will give enough permisson to IRSA so that it can talk to ASG+NodeGroup"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:DescribeScalingActivities",
          "autoscaling:DescribeTags",
          "ec2:DescribeImages",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeLaunchTemplateVersions",
          "ec2:GetInstanceTypesFromInstanceRequirements",
          "eks:DescribeNodegroup"
        ],
        "Resource" : ["*"]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup"
        ],
        "Resource" : ["*"]
      }
    ]
  })
}


resource "aws_iam_role" "clusterAutoscalar-role" {
  name = var.ROLE_CLUSTER_AUTOSCALAR_DRIVER

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
              "${var.EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT}:sub" : "system:serviceaccount:${var.CLUSTER_AUTOSCALAR_DRIVER_NAMESPACE}:${var.CLUSTER_AUTOSCALAR_DRIVER_SA_NAME}"
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

resource "aws_iam_role_policy_attachment" "clusterAutoscalar-policy-attachment" {
  role       = aws_iam_role.clusterAutoscalar-role.name
  policy_arn = aws_iam_policy.clusterAutoscalar-policy.arn
}

/*

There are 1 Ways to Deploy Driver

# 🔸 Helm

*/

# 🔸 Helm
# Lets install EBS CSI Driver through helm provider

resource "helm_release" "helm-clusterAutoscalar-driver" {
  depends_on = [ aws_iam_role_policy_attachment.clusterAutoscalar-policy-attachment  ]
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  namespace  = var.CLUSTER_AUTOSCALAR_DRIVER_NAMESPACE

  set {
    name  = "cloudProvider"
    value = "aws"
  }
  set {
    name  = "awsRegion"
    value = "us-east-1"
  }
  set {
    name  = "autoDiscovery.clusterName"
    value = "${var.CLUSTER_ID}"
  }
  set {
    name  = "rbac.serviceAccount.create"
    value = "true"
  }
  set {
    name  = "rbac.serviceAccount.name"
    value = var.CLUSTER_AUTOSCALAR_DRIVER_SA_NAME
  }
  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "${aws_iam_role.clusterAutoscalar-role.arn}"
  }
}

