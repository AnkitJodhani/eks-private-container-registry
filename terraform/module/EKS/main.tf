resource "aws_eks_cluster" "cluster" {
  name     = "${var.PROJECT_NAME}-eks-cluster"
  role_arn = var.EKS_MAIN_ROLE_ARN
  version  = var.CLUSTER_VERSION

  # where do you wanna place your Network interface PUBLIC OR PRIVATE
  vpc_config {
    subnet_ids              = [var.PUB_SUB_1_A_ID, var.PUB_SUB_2_B_ID]
    endpoint_private_access = var.CLUSTER_ENDPOINT_PRIVATE_ACCESS
    endpoint_public_access  = var.CLUSTER_ENDPOINT_PUBLIC_ACCESS
    public_access_cidrs     = var.CLUSTER_ENDPOINT_ACCESS_CIDR

  }
  kubernetes_network_config {
    service_ipv4_cidr = var.CLUSTER_SVC_CIDR
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  # depends_on = [
  #   aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
  #   aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
  # ]

  tags = {
    Name = "${var.PROJECT_NAME}-eks-cluster"
    env  = "${var.ENV}"
  }
}



# Uncomment if you want PUBLIC NODEGROUP

# resource "aws_eks_node_group" "public-nodegroup" {
#   cluster_name    = aws_eks_cluster.cluster.name
#   node_group_name = "${var.PROJECT_NAME}-eks-public-nodegroup"
#   node_role_arn   = var.EKS_MAIN_NODEGROUP_ROLE_ARN
#   subnet_ids      = [var.PUB_SUB_1_A_ID, var.PUB_SUB_2_B_ID]
#   version         = var.CLUSTER_VERSION
#   ami_type        = var.AMI_TYPE
#   instance_types  = var.INSTANCE_TYPE
#   capacity_type   = "ON_DEMAND"
#   disk_size       = 20
#   scaling_config {
#     desired_size = 2
#     max_size     = 4
#     min_size     = 2
#   }

#   update_config {
#     max_unavailable = 1
#   }

#   remote_access {
#     ec2_ssh_key = var.SSH_KEY_TO_ACCESS_NODE
#   }
#   # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#   # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#   # depends_on = [
#   #   aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
#   #   aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
#   #   aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
#   # ]
#   tags = {
#     Name = "${var.PROJECT_NAME}-eks-public-nodegroup"
# #     env  = "${var.ENV}"
#     # Cluster Autoscaler TAGS - CA needs below tags to identify and ADD the instances in ASG
#     "k8s.io/cluster-autoscaler/enabled"                         = "any-value" // ANY VALUE IF OKAY
#     "k8s.io/cluster-autoscaler/${aws_eks_cluster.cluster.name}" = "any-value" // ANY VALUE IF OKAY
#   }
# }



resource "aws_eks_node_group" "private-nodegroup" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "${var.PROJECT_NAME}-eks-private-nodegroup"
  node_role_arn   = var.EKS_MAIN_NODEGROUP_ROLE_ARN
  subnet_ids      = [var.PRI_SUB_3_A_ID, var.PRI_SUB_4_B_ID]
  version         = var.CLUSTER_VERSION
  ami_type        = var.AMI_TYPE
  instance_types  = var.INSTANCE_TYPE
  capacity_type   = var.NODE_CAPACITY_TYPE
  disk_size       = var.NODE_DISK_SIZE
  scaling_config {
    desired_size = var.DESIRED_NODE
    max_size     = var.MAX_NODE
    min_size     = var.MIN_NODE
  }

  update_config {
    max_unavailable = 1
  }
  # 📝 Uncomment below lines if you want to attach secret key(.pem file) for SSH into ec2 machine
  # remote_access {
  #   ec2_ssh_key = var.SSH_KEY_TO_ACCESS_NODE
  # }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  # depends_on = [
  #   aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
  #   aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
  #   aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  # ]
  tags = {
    Name = "${var.PROJECT_NAME}-eks-private-nodegroup"
    env  = "${var.ENV}"
    # Cluster Autoscaler TAGS - CA needs below tags to identify and ADD the instances in ASG
    "k8s.io/cluster-autoscaler/enabled"                         = "any-value" // ANY VALUE IS OKAY
    "k8s.io/cluster-autoscaler/${aws_eks_cluster.cluster.name}" = "any-value" // ANY VALUE IS OKAY
  }
}

data "aws_partition" "current" {}

data "tls_certificate" "get_thumbprint" {
  # we are using this provider to get the root ca thumbprint DYNAMICALLY
  # 👉  https://github.com/hashicorp/terraform-provider-tls/issues/52
  url = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks-oidc" {
  url = aws_eks_cluster.cluster.identity[0].oidc[0].issuer

  client_id_list = ["sts.${data.aws_partition.current.dns_suffix}"]

  # thumbprint_list = [var.EKS_OIDC_ROOT_CA_THUMBPRINT]
  thumbprint_list = [data.tls_certificate.get_thumbprint.certificates[0].sha1_fingerprint]
  tags = {
    Name = "${var.PROJECT_NAME}-eks-oidc-connect-provider "
    env  = "${var.ENV}"
  }
}


