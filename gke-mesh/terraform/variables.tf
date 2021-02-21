
variable "project_id" {
    description = "The GCP project ID"
    type        = string
}

variable "region" {
    description = "The region for  clusters"
    type        = string
}

variable "zones" {
    description = "The zones for clusters"
    type        = list
}

variable "cluster_name_prefix" {
    description = "The prefix of the Kubernetes cluster name"
    type        = string
}

variable "server_cluster_node_count" {
    description = "The clusters' node count"
    default     = 1
}

variable "client_cluster_node_count" {
    description = "The clusters' node count"
    default     = 1
}

variable "server_cluster_machine_type" {
    description = "The machine type for a default node pool"
    type        = string
    default     = "n1-standard-4"
}

variable "client_cluster_machine_type" {
    description = "The machine type for a default node pool"
    type        = string
    default     = "n1-standard-4"
}

variable "client_cluster_count" {
    description = "The number of client clusters"
}

variable "acm_repo_location" {
  description = "The location of the git repo ACM will sync to"
}
variable "acm_branch" {
  description = "The git branch ACM will sync to"
}
variable "acm_dir" {
  description = "The directory in git ACM will sync to"
}


