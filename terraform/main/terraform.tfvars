# 👇 Common variable
ENV          = "prod"
REGION       = "us-east-1"
PROJECT_NAME = "private-registry"

# 👇 VPC variables
VPC_CIDR         = "192.168.0.0/16"
PUB_SUB_1_A_CIDR = "192.168.0.0/18"
PUB_SUB_2_B_CIDR = "192.168.64.0/18"
PRI_SUB_3_A_CIDR = "192.168.128.0/18"
PRI_SUB_4_B_CIDR = "192.168.192.0/18"

# 👇 EKS cluster variables
CLUSTER_SVC_CIDR                = "10.20.0.0/16"
CLUSTER_VERSION                 = "1.29"
CLUSTER_ENDPOINT_PRIVATE_ACCESS = false
CLUSTER_ENDPOINT_PUBLIC_ACCESS  = true
CLUSTER_ENDPOINT_ACCESS_CIDR    = ["0.0.0.0/0"]

# 👇 EKS Nodegroup variables
INSTANCE_TYPE      = ["t3.medium"]
AMI_TYPE           = "AL2_x86_64"
NODE_CAPACITY_TYPE = "ON_DEMAND"
NODE_DISK_SIZE     = 20
MAX_NODE           = 4
MIN_NODE           = 2
DESIRED_NODE       = 2
# SSH_KEY_TO_ACCESS_NODE = "control-machine"

# 👇 Metrics server
METRICS_SERVER_DRIVER_NAMESPACE = "kube-system"
METRICS_SERVER_DRIVER_SA_NAME   = "metrics-server-sa"

# 👇 EBS CSI Driver
ROLE_EBS_CSI_DRIVER      = "EBSCSIDriver"
EBS_CSI_DRIVER_NAMESPACE = "kube-system"
EBS_CSI_DRIVER_SA_NAME   = "ebs-csi-controller-sa"

# 👇 EFS CSI Driver
ROLE_EFS_CSI_DRIVER      = "EFSCSIDriver"
EFS_CSI_DRIVER_NAMESPACE = "kube-system"
EFS_CSI_DRIVER_SA_NAME   = "efs-csi-controller-sa"

# 👇 EFS CSI Driver
ROLE_LBC      = "ALBController"
LBC_NAMESPACE = "kube-system"
LBC_SA_NAME   = "aws-load-balancer-controller"

# 👇 ExternalDNS Driver
ROLE_AllowExternalDNSUpdates = "AllowExternalDNSUpdates-terraform"
EXTERNAL_DNS_NAMESPACE       = "kube-system"
EXTERNAL_DNS_SA_NAME         = "external-dns-sa"

# 👇 Cluster Autoscalar
ROLE_CLUSTER_AUTOSCALAR_DRIVER      = "ClusterAutoScalarDriver"
CLUSTER_AUTOSCALAR_DRIVER_NAMESPACE = "kube-system"
CLUSTER_AUTOSCALAR_DRIVER_SA_NAME   = "cluster-autoscalar-sa"

# 👇 Container Insight
ROLE_CONTAINER_INSIGHT_DRIVER      = "ContainerInsight"
CONTAINER_INSIGHT_DRIVER_NAMESPACE = "amazon-cloudwatch"
CONTAINER_INSIGHT_DRIVER_SA_NAME   = "cloudwatch-agent"

# 👇 VPC CNI
ROLE_VPC_CNI      = "AmazonEKSVPCCNIRole"
VPC_CNI_NAMESPACE = "kube-system"
VPC_CNI_SA_NAME   = "aws-node"
