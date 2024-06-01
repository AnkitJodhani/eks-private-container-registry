# 🌟  Create VPC
module "VPC" {
  source           = "../module/VPC"
  REGION           = var.REGION
  PROJECT_NAME     = var.PROJECT_NAME
  VPC_CIDR         = var.VPC_CIDR
  PUB_SUB_1_A_CIDR = var.PUB_SUB_1_A_CIDR
  PUB_SUB_2_B_CIDR = var.PUB_SUB_2_B_CIDR
  PRI_SUB_3_A_CIDR = var.PRI_SUB_3_A_CIDR
  PRI_SUB_4_B_CIDR = var.PRI_SUB_4_B_CIDR

}

# 🌟  Create IAM Roles with required permission
module "IAM" {
  source       = "../module/IAM"
  PROJECT_NAME = module.VPC.PROJECT_NAME
  ENV          = var.PROJECT_NAME
}

# 🌟  Create EKS Cluster + NodeGroup
module "EKS" {
  source                          = "../module/EKS"
  PROJECT_NAME                    = module.VPC.PROJECT_NAME
  EKS_MAIN_ROLE_ARN               = module.IAM.EKS_MAIN_ROLE_ARN
  ENV                             = var.ENV
  REGION                          = var.REGION
  CLUSTER_VERSION                 = var.CLUSTER_VERSION
  PUB_SUB_1_A_ID                  = module.VPC.PUB_SUB_1_A_ID
  PUB_SUB_2_B_ID                  = module.VPC.PUB_SUB_2_B_ID
  PRI_SUB_3_A_ID                  = module.VPC.PRI_SUB_3_A_ID
  PRI_SUB_4_B_ID                  = module.VPC.PRI_SUB_4_B_ID
  CLUSTER_ENDPOINT_PRIVATE_ACCESS = var.CLUSTER_ENDPOINT_PRIVATE_ACCESS
  CLUSTER_ENDPOINT_PUBLIC_ACCESS  = var.CLUSTER_ENDPOINT_PUBLIC_ACCESS
  CLUSTER_ENDPOINT_ACCESS_CIDR    = var.CLUSTER_ENDPOINT_ACCESS_CIDR
  CLUSTER_SVC_CIDR                = var.CLUSTER_SVC_CIDR
  EKS_MAIN_NODEGROUP_ROLE_ARN     = module.IAM.EKS_MAIN_NODEGROUP_ROLE_ARN
  INSTANCE_TYPE                   = var.INSTANCE_TYPE
  AMI_TYPE                        = var.AMI_TYPE
  NODE_CAPACITY_TYPE              = var.NODE_CAPACITY_TYPE
  NODE_DISK_SIZE                  = var.NODE_DISK_SIZE
  MAX_NODE                        = var.MAX_NODE
  MIN_NODE                        = var.MIN_NODE
  DESIRED_NODE                    = var.DESIRED_NODE
  # SSH_KEY_TO_ACCESS_NODE          = var.SSH_KEY_TO_ACCESS_NODE

}

# 🌟  Deploy VPC-CNI Addon
module "IAM_VPC_CNI" {
  depends_on                            = [module.EKS]
  source                                = "../module/tools/VPC-CNI"
  ENV                                   = var.ENV
  CLUSTER_ID                            = module.EKS.CLUSTER_ID
  EKS_OIDC_CONNECT_PROVIDER_ARN         = module.EKS.EKS_OIDC_CONNECT_PROVIDER_ARN
  EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT = module.EKS.EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT
  ROLE_VPC_CNI                          = var.ROLE_VPC_CNI
  VPC_CNI_NAMESPACE                     = var.VPC_CNI_NAMESPACE
  VPC_CNI_SA_NAME                       = var.VPC_CNI_SA_NAME
}

/*
# 🌟  Deploy Metrics server
module "METRICS_SERVER" {
  depends_on                      = [module.IAM_VPC_CNI]
  source                          = "../module/tools/Metrics_server"
  METRICS_SERVER_DRIVER_NAMESPACE = var.METRICS_SERVER_DRIVER_NAMESPACE
  METRICS_SERVER_DRIVER_SA_NAME   = var.METRICS_SERVER_DRIVER_SA_NAME
}
*/

/*
# 🌟  Deploy EBS CSI Driver
module "IAM_EBS_CSI" {
  depends_on                            = [module.IAM_VPC_CNI]
  source                                = "../module/tools/EBS-IRSA"
  ENV                                   = var.ENV
  CLUSTER_ID                            = module.EKS.CLUSTER_ID
  EKS_OIDC_CONNECT_PROVIDER_ARN         = module.EKS.EKS_OIDC_CONNECT_PROVIDER_ARN
  EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT = module.EKS.EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT
  ROLE_EBS_CSI_DRIVER                   = var.ROLE_EBS_CSI_DRIVER
  EBS_CSI_DRIVER_NAMESPACE              = var.EBS_CSI_DRIVER_NAMESPACE
  EBS_CSI_DRIVER_SA_NAME                = var.EBS_CSI_DRIVER_SA_NAME
}
*/

# 🌟  Deploy EFS CSI Driver
module "IAM_EFS_CSI" {
  depends_on                            = [module.IAM_VPC_CNI]
  source                                = "../module/tools/EFS-IRSA"
  ENV                                   = var.ENV
  CLUSTER_ID                            = module.EKS.CLUSTER_ID
  EKS_OIDC_CONNECT_PROVIDER_ARN         = module.EKS.EKS_OIDC_CONNECT_PROVIDER_ARN
  EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT = module.EKS.EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT
  ROLE_EFS_CSI_DRIVER                   = var.ROLE_EFS_CSI_DRIVER
  EFS_CSI_DRIVER_NAMESPACE              = var.EFS_CSI_DRIVER_NAMESPACE
  EFS_CSI_DRIVER_SA_NAME                = var.EFS_CSI_DRIVER_SA_NAME
}

# 🌟  Deploy AWS Load Balancer Controller
module "IAM_LBC" {
  depends_on                            = [module.IAM_VPC_CNI]
  source                                = "../module/tools/LBC-IRSA"
  ENV                                   = var.ENV
  CLUSTER_ID                            = module.EKS.CLUSTER_ID
  EKS_OIDC_CONNECT_PROVIDER_ARN         = module.EKS.EKS_OIDC_CONNECT_PROVIDER_ARN
  EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT = module.EKS.EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT
  ROLE_LBC                              = var.ROLE_LBC
  LBC_NAMESPACE                         = var.LBC_NAMESPACE
  LBC_SA_NAME                           = var.LBC_SA_NAME
}

# 🌟  Deploy External DNS
module "IAM_EXTERNALDNS" {
  depends_on                            = [module.IAM_VPC_CNI]
  source                                = "../module/tools/ExternalDNS-IRSA"
  ENV                                   = var.ENV
  CLUSTER_ID                            = module.EKS.CLUSTER_ID
  EKS_OIDC_CONNECT_PROVIDER_ARN         = module.EKS.EKS_OIDC_CONNECT_PROVIDER_ARN
  EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT = module.EKS.EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT
  ROLE_AllowExternalDNSUpdates          = var.ROLE_AllowExternalDNSUpdates
  EXTERNAL_DNS_NAMESPACE                = var.EXTERNAL_DNS_NAMESPACE
  EXTERNAL_DNS_SA_NAME                  = var.EXTERNAL_DNS_SA_NAME
}

/*
# 🌟  Deploy Cluster Autoscalar
module "IAM_CLUSTER_AUTOSCALAR" {
  depends_on                            = [module.IAM_VPC_CNI]
  source                                = "../module/tools/CA-IRSA"
  ENV                                   = var.ENV
  CLUSTER_ID                            = module.EKS.CLUSTER_ID
  EKS_OIDC_CONNECT_PROVIDER_ARN         = module.EKS.EKS_OIDC_CONNECT_PROVIDER_ARN
  EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT = module.EKS.EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT
  ROLE_CLUSTER_AUTOSCALAR_DRIVER        = var.ROLE_CLUSTER_AUTOSCALAR_DRIVER
  CLUSTER_AUTOSCALAR_DRIVER_NAMESPACE   = var.CLUSTER_AUTOSCALAR_DRIVER_NAMESPACE
  CLUSTER_AUTOSCALAR_DRIVER_SA_NAME     = var.CLUSTER_AUTOSCALAR_DRIVER_SA_NAME
}
*/

/*
# 🌟  Deploy Container Insight
module "IAM_CONTAINER_INSIGHT" {
  depends_on                            = [module.IAM_VPC_CNI]
  source                                = "../module/tools/Container-insights-IRSA"
  ENV                                   = var.ENV
  CLUSTER_ID                            = module.EKS.CLUSTER_ID
  EKS_OIDC_CONNECT_PROVIDER_ARN         = module.EKS.EKS_OIDC_CONNECT_PROVIDER_ARN
  EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT = module.EKS.EKS_OIDC_CONNECT_PROVIDER_ARN_EXTRACT
  ROLE_CONTAINER_INSIGHT_DRIVER         = var.ROLE_CONTAINER_INSIGHT_DRIVER
  CONTAINER_INSIGHT_DRIVER_NAMESPACE    = var.CONTAINER_INSIGHT_DRIVER_NAMESPACE
  CONTAINER_INSIGHT_DRIVER_SA_NAME      = var.CONTAINER_INSIGHT_DRIVER_SA_NAME
}
*/