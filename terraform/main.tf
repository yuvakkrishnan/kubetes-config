terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.11.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.11.0"
    }
  }
}

# Kubernetes provider
provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Helm provider (new v3.x syntax)
provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "kubetes" {
  name       = "kubetes"
  chart      = "../helm/kubetes"
  namespace  = "default"

  set = [
    {
      name  = "image.repository"
      value = "yuvakkrishnans/kubetes"
    },
    {
      name  = "image.tag"
      value = "latest"
    },
    {
      name  = "service.port"
      value = "8089"
    }
  ]
}