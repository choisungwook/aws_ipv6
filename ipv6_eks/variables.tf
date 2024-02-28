variable "ipv6_dualstack_ec2_key_name" {
  description = "ipv6 ec2 key name"
  type        = string
}

variable "assume_role_arn" {
  description = "assume role arn for EKS auth-configmap"
  type        = string
}

# variable "eks_cluster_name" {
#   type = string
# }
