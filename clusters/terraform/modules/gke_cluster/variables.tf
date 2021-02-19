variable "location" {
    description = "The location the GKE cluster"
}

variable "cluster_name" {
    description = "The name of the GKE cluster"
}

variable "description" {
    description = "The cluster's description"
    default = "TFF execution cluster"
}

variable "node_count" {
    description = "The cluster's node count"
    default     = 2
}

variable "sa_email" {
    description = "The email account of the GKE service account"
}

variable "machine_type" {
    description = "A machine type for the default node pool"
    default     = "n1-standard-4"
}
