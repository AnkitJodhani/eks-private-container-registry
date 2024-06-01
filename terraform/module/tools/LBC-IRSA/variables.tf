# Common variable for creating role and policy
variable "CLUSTER_ID" {}
variable "ENV" {}
variable "EKS_OIDC_CONNECT_PROVIDER_ARN" {}
variable "EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT" {}


#  specific variable
variable "ROLE_LBC" {}
variable "LBC_NAMESPACE" {}
variable "LBC_SA_NAME" {}