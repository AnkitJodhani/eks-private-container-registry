# 👇 Common variable
variable "ENV" {}
variable "REGION" {}
variable "PROJECT_NAME" {}

# 👇 VPC variables
variable "VPC_CIDR" {}
variable "PUB_SUB_1_A_CIDR" {}
variable "PUB_SUB_2_B_CIDR" {}
variable "PRI_SUB_3_A_CIDR" {}
variable "PRI_SUB_4_B_CIDR" {}

# 👇 EKS cluster variables
variable "CLUSTER_SVC_CIDR" {}
variable "CLUSTER_VERSION" {}
variable "CLUSTER_ENDPOINT_PRIVATE_ACCESS" {}
variable "CLUSTER_ENDPOINT_PUBLIC_ACCESS" {}
variable "CLUSTER_ENDPOINT_ACCESS_CIDR" {}

# 👇 EKS Nodegroup variables
variable "INSTANCE_TYPE" {}
variable "AMI_TYPE" {}
variable "NODE_CAPACITY_TYPE" {}
variable "NODE_DISK_SIZE" {}
variable "MAX_NODE" {}
variable "MIN_NODE" {}
variable "DESIRED_NODE" {}
# variable "SSH_KEY_TO_ACCESS_NODE" {}


# 👇 variables for Metrics server
variable "METRICS_SERVER_DRIVER_NAMESPACE" {}
variable "METRICS_SERVER_DRIVER_SA_NAME" {}

# 👇 variables for # EBS CSI driver
variable "ROLE_EBS_CSI_DRIVER" {}
variable "EBS_CSI_DRIVER_NAMESPACE" {}
variable "EBS_CSI_DRIVER_SA_NAME" {}

# 👇 Variable for EFS Driver
variable "ROLE_EFS_CSI_DRIVER" {}
variable "EFS_CSI_DRIVER_NAMESPACE" {}
variable "EFS_CSI_DRIVER_SA_NAME" {}

# 👇 Variable for AWS LBC
variable "ROLE_LBC" {}
variable "LBC_NAMESPACE" {}
variable "LBC_SA_NAME" {}

# 👇 Variable for External-DNS
variable "ROLE_AllowExternalDNSUpdates" {}
variable "EXTERNAL_DNS_NAMESPACE" {}
variable "EXTERNAL_DNS_SA_NAME" {}

# 👇 Variable for Cluster Autoscalar
variable "ROLE_CLUSTER_AUTOSCALAR_DRIVER" {}
variable "CLUSTER_AUTOSCALAR_DRIVER_NAMESPACE" {}
variable "CLUSTER_AUTOSCALAR_DRIVER_SA_NAME" {}

# 👇 Variable for Container Insight
variable "ROLE_CONTAINER_INSIGHT_DRIVER" {}
variable "CONTAINER_INSIGHT_DRIVER_NAMESPACE" {}
variable "CONTAINER_INSIGHT_DRIVER_SA_NAME" {}


# 👇 Variable VPC CNI
variable "ROLE_VPC_CNI" {}
variable "VPC_CNI_NAMESPACE" {}
variable "VPC_CNI_SA_NAME" {}
