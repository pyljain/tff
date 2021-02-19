
variable "cluster_sa_id" {
    description = "Least Privilege GKE account ID"
}

variable "cluster_sa_roles" {
    description = "The list of roles to assign to the GKE service account"
    default     = ["logging.logWriter",
                   "monitoring.metricWriter",
                   "monitoring.viewer",
                   "stackdriver.resourceMetadata.writer",
                   "storage.objectViewer"]
}

