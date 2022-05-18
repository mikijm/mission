# https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }
  }
}
