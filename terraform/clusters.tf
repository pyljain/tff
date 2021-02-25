# Server Cluster
module "server-cluster" {
  name                     = "${var.cluster_name_prefix}-server"
  project_id               = module.project-services.project_id
  source                   = "github.com/terraform-google-modules/terraform-google-kubernetes-engine//modules/beta-public-cluster?ref=v13.1.0"
  regional                 = false
  region                   = var.region
  network                  = "default"
  subnetwork               = "default"
  ip_range_pods            = ""
  ip_range_services        = ""
  zones                    = var.zones
  release_channel          = "REGULAR"
  grant_registry_access    = true
  remove_default_node_pool = true
  cluster_resource_labels = { "mesh_id" : "proj-${data.google_project.project.number}" }
  node_pools = [
    {
      name         = "default-node-pool"
      autoscaling  = false
      auto_upgrade = true

      node_count   = var.server_cluster_node_count
      machine_type = var.server_cluster_machine_type
    },
  ]

}

# Client Clusters
module "client-clusters" {
  count                    = var.client_cluster_count
  name                     = "${var.cluster_name_prefix}-client-${count.index}"
  project_id               = module.project-services.project_id
  source                   = "github.com/terraform-google-modules/terraform-google-kubernetes-engine//modules/beta-public-cluster?ref=v13.1.0"
  regional                 = false
  region                   = var.region
  network                  = "default"
  subnetwork               = "default"
  ip_range_pods            = ""
  ip_range_services        = ""
  zones                    = var.zones
  release_channel          = "REGULAR"
  grant_registry_access    = true
  remove_default_node_pool = true
  cluster_resource_labels = { "mesh_id" : "proj-${data.google_project.project.number}" }

  node_pools = [
    {
      name         = "default-node-pool"
      autoscaling  = false
      auto_upgrade = true

      node_count   = var.client_cluster_node_count
      machine_type = var.client_cluster_machine_type
    },
  ]

}