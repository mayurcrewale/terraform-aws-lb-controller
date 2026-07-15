variable "cluster_name" {
  description = "Name of the EKS cluster to install the controller into."
  type        = string
}

variable "region" {
  description = "AWS region of the cluster."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID of the cluster (passed to the controller so it doesn't have to auto-discover it)."
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the EKS cluster's IAM OIDC provider (from the eks-cluster module)."
  type        = string
}

variable "oidc_provider_url" {
  description = "OIDC provider URL without the https:// prefix (from the eks-cluster module)."
  type        = string
}

variable "namespace" {
  description = "Namespace to install the controller into."
  type        = string
  default     = "kube-system"
}

variable "service_account_name" {
  description = "Name of the Kubernetes ServiceAccount used by the controller."
  type        = string
  default     = "aws-load-balancer-controller"
}

variable "chart_version" {
  description = "Version of the aws-load-balancer-controller Helm chart to install."
  type        = string
  default     = "1.9.2"
}

variable "replica_count" {
  type    = number
  default = 1
}

variable "tags" {
  type    = map(string)
  default = {}
}
