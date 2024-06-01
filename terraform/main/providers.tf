terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      # we are using this provider to get the ROOT CA Thumbprint Dynamically
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.27"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.4"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                   = var.REGION
  # shared_config_files      = ["C:\\Users\\ankit\\.aws\\config"]
  # shared_credentials_files = ["C:\\Users\\ankit\\.aws\\credentials"]
  # # profile                  = "default"
}

data "aws_eks_cluster" "cluster" {
  name = module.EKS.CLUSTER_ID
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.EKS.CLUSTER_ID
}

provider "kubernetes" {
  # Configuration options
  host                   = module.EKS.CLUSTER_ENDPOINT
  cluster_ca_certificate = base64decode(module.EKS.KUBECONFIG_CERTIFICATE_AUTHORITY_DATA)
  token                  = data.aws_eks_cluster_auth.cluster.token
}


provider "helm" {
  kubernetes {
    host                   = module.EKS.CLUSTER_ENDPOINT
    cluster_ca_certificate = base64decode(module.EKS.KUBECONFIG_CERTIFICATE_AUTHORITY_DATA)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}
