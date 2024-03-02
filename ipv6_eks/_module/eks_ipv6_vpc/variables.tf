variable "tag_prefix" {
  description = "tag prefix"
  type        = string
  default     = "EKS-ipv6"
}

variable "eks_cluster_name" {
  description = "eks cluster name"
  type        = string
}

variable "vpc_cidr" {
  description = "vpc cidr"
  type        = string
}

variable "public_subnets" {
  description = "public subnets"
  type = map(object({
    az                 = string
    ipv4_cidr          = string
    ipv6_subnet_netnum = number
  }))
}

variable "private_subnets" {
  description = "private subnets"
  type = map(object({
    az                 = string
    ipv4_cidr          = string
    ipv6_subnet_netnum = number
  }))
}
