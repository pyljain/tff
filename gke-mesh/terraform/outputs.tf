output "server_cluster_name" {
    value = module.server_cluster.cluster_name
}

output "server_cluster_endpoint" {
    value = module.server_cluster.cluster_endpoint
}

output "lp_sa_email" {
    value = module.service_accounts.cluster_sa_email
}

output "lp_sa_name" {
    value = module.service_accounts.cluster_sa_name
}

