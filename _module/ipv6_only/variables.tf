variable "tag_prefix" {
  description = "tag prefix"
  type        = string
  default     = "Example-ipv6only"
}

variable "vpc_cidr" {
  description = "vpc cidr"
  type        = string
}

variable "public_subnets_ipv6" {
  description = "ipv6 public subnets"
  type = map(object({
    az                 = string
    ipv6_subnet_netnum = number
  }))
}

variable "private_subnets_ipv6" {
  description = "ipv6 private subnets"
  type = map(object({
    az                 = string
    ipv6_subnet_netnum = number
  }))
}

##############################
## nat64 gateway subnet
##############################

variable "public_subnets_ipv4" {
  description = "ipv4 public subnets"
  type = map(object({
    az   = string
    cidr = string
  }))
}
