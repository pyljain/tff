
terraform {
  required_version = ">= 0.14"
  required_providers {
    google = "~> 3.5"
  }

  backend "gcs" {
    bucket  = "jk-terraform-state"
    prefix  = "federated-learning"
  }
}

provider "google" {
    project   = var.project_id 
}

data "google_project" "project" {}

data "google_compute_default_service_account" "default" {}

# Enable cloud services and configure service accounts: 
module "service_accounts" {
    source    = "./modules/service_accounts"
    cluster_sa_id  = var.cluster_sa_id
}

# Configure a GKE cluster to host TFF server
module "server_cluster" {
    source       = "./modules/gke_cluster"
    location     = var.cluster_location
    cluster_name = "${var.cluster_name_prefix}-server"
    sa_email     = module.service_accounts.cluster_sa_email
}

# Configure a GKE clusters to host TFF clients
module "client_cluster" {
    count        = var.client_cluster_count
    source       = "./modules/gke_cluster"
    location     = var.cluster_location
    cluster_name = "${var.cluster_name_prefix}-client-${count.index}"
    sa_email     = module.service_accounts.cluster_sa_email
}

# Create GCS bucket for pipeline artifacts
#resource "google_storage_bucket" "artifacts-store" {
#  name          = var.bucket_name
#  storage_class = "MULTI_REGIONAL"
#  force_destroy = true
#}


