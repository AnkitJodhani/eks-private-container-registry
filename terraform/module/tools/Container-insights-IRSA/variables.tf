# Common variable for creating role and policy
variable "CLUSTER_ID" {}
variable "ENV" {}
variable "EKS_OIDC_CONNECT_PROVIDER_ARN" {}
variable "EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT" {}


#  specific variable
variable "ROLE_CONTAINER_INSIGHT_DRIVER" {}
variable "CONTAINER_INSIGHT_DRIVER_NAMESPACE" {}
variable "CONTAINER_INSIGHT_DRIVER_SA_NAME" {}