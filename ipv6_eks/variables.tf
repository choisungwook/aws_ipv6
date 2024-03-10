variable "assume_role_arn" {
  description = "assume role arn for EKS auth-configmap"
  type        = string
}

variable "eks_cluster_name" {
  type = string
}

variable "eks_version" {
  type    = string
  default = "1.28"
}

variable "addon_kube_proxy_version" {
  type    = string
  default = "v1.28.2-eksbuild.2"
}

variable "addon_vpc_cni" {
  type    = string
  default = "v1.15.1-eksbuild.1"
}

variable "addon_coredns" {
  type    = string
  default = "v1.10.1-eksbuild.4"
}

variable "vpc_cni_irsa_role_arn" {
  type = string
}
