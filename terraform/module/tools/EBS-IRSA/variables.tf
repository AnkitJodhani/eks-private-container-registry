# Common variable for creating role and policy
variable "CLUSTER_ID" {}
variable "ENV" {}
variable "EKS_OIDC_CONNECT_PROVIDER_ARN" {}
variable "EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT" {}


#  specific variable
variable "ROLE_EBS_CSI_DRIVER" {}
variable "EBS_CSI_DRIVER_NAMESPACE" {}
variable "EBS_CSI_DRIVER_SA_NAME" {}