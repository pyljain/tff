

# Configure the GKE cluster service account with the minimum necessary roles and permissions in order to run the GKE cluster

resource "google_service_account" "cluster_sa" {
    account_id   = var.cluster_sa_id
    display_name = "Least Priviledge Service Account"
}

resource "google_project_iam_member" "cluster_sa_roles" {
  count   = length(var.cluster_sa_roles)
  role    = "roles/${var.cluster_sa_roles[count.index]}"
  member  = "serviceAccount:${google_service_account.cluster_sa.email}"
}


