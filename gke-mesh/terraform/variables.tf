
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

variable "cluster_sa_id" {
    description = "The ID of the Least Priviledge GKE service account"
    default     = "gke-sa"
}

variable "client_cluster_count" {
    description = "The number of client clusters"
}

