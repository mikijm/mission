terraform {

    required_version = ">= 0.13.0"

    required_providers {
        google = {
          source  = "hashicorp/google"
          version = "~> 4.0"
        }
        helm = {
            source = "hashicorp/helm"
            version = "2.4.1"
        }
        kubernetes = {
            source = "hashicorp/kubernetes"
            version = "2.8.0"     
        }
        kubectl = {
            source = "gavinbunney/kubectl"
            version = "1.13.1"
        }
    }
}

# Retrieve an access token as the Terraform runner
data "google_client_config" "provider" {}

data "google_container_cluster" "primary" {
  name     = var.cluster_name 
  location = var.region
  project  = var.project
}

provider "kubernetes" {
  host  = "https://${google_container_cluster.primary.endpoint}"
  token = data.google_client_config.provider.access_token
#  client_certificate     = base64decode( google_container_cluster.primary.master_auth[0].client_certificate )
#  client_key             = base64decode( google_container_cluster.primary.master_auth[0].client_key )
  cluster_ca_certificate = base64decode( google_container_cluster.primary.master_auth[0].cluster_ca_certificate )
}

provider "helm" {
  kubernetes {
    host  = "https://${google_container_cluster.primary.endpoint}"
    token = data.google_client_config.provider.access_token
 #   client_certificate     = base64decode( google_container_cluster.primary.master_auth[0].client_certificate )
 #   client_key             = base64decode( google_container_cluster.primary.master_auth[0].client_key )
    cluster_ca_certificate = base64decode( google_container_cluster.primary.master_auth[0].cluster_ca_certificate )
  }
}

provider "kubectl" {
  host  = "https://${google_container_cluster.primary.endpoint}"
  token = data.google_client_config.provider.access_token
#  client_certificate     = base64decode( google_container_cluster.primary.master_auth[0].client_certificate )
#  client_key             = base64decode( google_container_cluster.primary.master_auth[0].client_key )
  cluster_ca_certificate = base64decode( google_container_cluster.primary.master_auth[0].cluster_ca_certificate )

  load_config_file = false
}
