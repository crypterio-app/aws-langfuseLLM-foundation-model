
variable "kind_cluster_name" {
  description = "The name of the Kind cluster"
  type        = string
}

variable "kind_cluster_config_path" {
  description = "Path to save the Kind kubeconfig file"
  type        = string
}

variable "k8s_version" {
  description = "Kubernetes version to use for Kind nodes"
  type        = string
}

variable "worker_count" {
  description = "Number of worker nodes"
  type        = number
}

variable "additional_control_planes_count" {
  description = "Number of additional control planes for HA"
  type        = number
  default     = 2
}

variable "ingress_nginx_helm_version" {
  type        = string
  description = "The Helm version for the nginx ingress controller."
  default     = "4.0.6"
}

variable "ingress_nginx_namespace" {
  type        = string
  description = "The nginx ingress namespace (it will be created if needed)."
  default     = "ingress-nginx"
}
