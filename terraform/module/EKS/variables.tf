

variable "PROJECT_NAME" {}
variable "EKS_MAIN_ROLE_ARN" {}
variable "CLUSTER_VERSION" {}

variable "PUB_SUB_1_A_ID" {}
variable "PUB_SUB_2_B_ID" {}
variable "PRI_SUB_3_A_ID" {}
variable "PRI_SUB_4_B_ID" {}


variable "CLUSTER_ENDPOINT_PRIVATE_ACCESS" {}
variable "CLUSTER_ENDPOINT_PUBLIC_ACCESS" {}

variable "CLUSTER_ENDPOINT_ACCESS_CIDR" {}
variable "CLUSTER_SVC_CIDR" {}
variable "EKS_MAIN_NODEGROUP_ROLE_ARN" {}
variable "ENV" {}
variable "REGION" {}

variable "INSTANCE_TYPE" {}
variable "AMI_TYPE" {}
variable "NODE_CAPACITY_TYPE" {}
variable "NODE_DISK_SIZE" {}
variable "MAX_NODE" {}
variable "MIN_NODE" {}
variable "DESIRED_NODE" {}
# variable "SSH_KEY_TO_ACCESS_NODE" {}

# variable "EKS_OIDC_ROOT_CA_THUMBPRINT" {}