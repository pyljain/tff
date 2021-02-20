
output "cluster_sa_email" {
    value = google_service_account.cluster_sa.email
}

output "cluster_sa_name" {
    value = google_service_account.cluster_sa.name
}
