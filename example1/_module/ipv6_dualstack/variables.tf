variable "tag_prefix" {
  description = "tag prefix"
  type        = string
  default     = "Example1-ipv6-dualstack"
}

variable "vpc_id" {
  description = "id"
  type        = string
}

variable "vpc_ipv6_cidr" {
  description = "vpc ipv6 cidr"
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

variable "internet_gateway_id" {
  description = "internet gateway id"
  type        = string
}
