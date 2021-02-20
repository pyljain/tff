


# Create a GKE cluster with a default node pool 
resource "google_container_cluster" "gke_cluster" {
  name               = var.cluster_name
  location           = var.location
  description        = var.description

  initial_node_count = var.node_count

  node_config {
    machine_type = var.machine_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    service_account = var.sa_email

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
  