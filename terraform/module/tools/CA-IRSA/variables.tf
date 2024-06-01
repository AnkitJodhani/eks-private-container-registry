# Common variable for creating role and policy
variable "CLUSTER_ID" {}
variable "ENV" {}
variable "EKS_OIDC_CONNECT_PROVIDER_ARN" {}
variable "EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT" {}


#  specific variable
variable "ROLE_CLUSTER_AUTOSCALAR_DRIVER" {}
variable "CLUSTER_AUTOSCALAR_DRIVER_NAMESPACE" {}
variable "CLUSTER_AUTOSCALAR_DRIVER_SA_NAME" {}