
variable "project_id" {
    description = "The GCP project ID"
    type        = string
}

variable "cluster_location" {
    description = "The location the GKE cluster"
}

variable "cluster_name" {
    description = "The name of the Kubernetes cluster"
}

variable "cluster_node_count" {
    description = "The cluster's node count"
    default     = 2
}

variable "cluster_sa_id" {
    description = "The ID of the Least Priviledge GKE service account"
    default     = "gke-sa"
}

