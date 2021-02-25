module "acm-server" {
  source           = "github.com/terraform-google-modules/terraform-google-kubernetes-engine//modules/acm?ref=v13.1.0"

  project_id       = data.google_client_config.current.project
  cluster_name     = module.server-cluster.name
  location         = module.server-cluster.location
  cluster_endpoint = module.server-cluster.endpoint

  operator_path    = "config-management-operator.yaml"
  sync_repo        = var.acm_repo_location
  sync_branch      = var.acm_branch
  policy_dir       = var.acm_dir
  secret_type      = var.acm_secret_type
  create_ssh_key   = var.acm_create_ssh_key
}

module "acm-clients" {
  count            = var.client_cluster_count
  source           = "github.com/terraform-google-modules/terraform-google-kubernetes-engine//modules/acm?ref=v13.1.0"

  project_id       = data.google_client_config.current.project
  cluster_name     = module.client-clusters[count.index].name
  location         = module.client-clusters[count.index].location
  cluster_endpoint = module.client-clusters[count.index].endpoint

  operator_path    = "config-management-operator.yaml"
  sync_repo        = var.acm_repo_location
  sync_branch      = var.acm_branch
  policy_dir       = var.acm_dir
  secret_type      = var.acm_secret_type
  create_ssh_key   = var.acm_create_ssh_key
}