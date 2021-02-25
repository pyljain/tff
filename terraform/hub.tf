module "hub-server" {
  source           = "terraform-google-modules/kubernetes-engine/google//modules/hub?ref=v13.1.0"
  project_id       = data.google_client_config.current.project

  cluster_name     = module.server-cluster.name
  location         = module.server-cluster.location
  cluster_endpoint = module.server-cluster.endpoint
  gke_hub_membership_name = "server"
  gke_hub_sa_name = "server"
}

module "hub-clients" {
  count            = var.client_cluster_count
  source           = "terraform-google-modules/kubernetes-engine/google//modules/hub?ref=v13.1.0"
  project_id       = data.google_client_config.current.project

  cluster_name     = module.client-clusters[count.index].name
  location         = module.client-clusters[count.index].location
  cluster_endpoint = module.client-clusters[count.index].endpoint
  gke_hub_membership_name = "client-${count.index}"
  gke_hub_sa_name = "client-${count.index}"
}