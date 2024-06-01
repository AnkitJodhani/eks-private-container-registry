# Common variable for creating role and policy
variable "CLUSTER_ID" {}
variable "ENV" {}
variable "EKS_OIDC_CONNECT_PROVIDER_ARN" {}
variable "EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT" {}


#  specific variable
variable "ROLE_AllowExternalDNSUpdates" {}
variable "EXTERNAL_DNS_NAMESPACE" {}
variable "EXTERNAL_DNS_SA_NAME" {}