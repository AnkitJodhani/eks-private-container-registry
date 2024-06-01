# Common variable for creating role and policy
variable "CLUSTER_ID" {}
variable "ENV" {}
variable "EKS_OIDC_CONNECT_PROVIDER_ARN" {}
variable "EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT" {}


#  specific variable
variable "ROLE_EFS_CSI_DRIVER" {}
variable "EFS_CSI_DRIVER_NAMESPACE" {}
variable "EFS_CSI_DRIVER_SA_NAME" {}