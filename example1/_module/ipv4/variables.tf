variable "tag_prefix" {
  description = "tag prefix"
  type        = string
  default     = "Example1"
}

variable "vpc_id" {
  description = "id"
  type        = string
}

variable "public_subnets" {
  description = "public subnets"
  type = map(object({
    az   = string
    cidr = string
  }))
}

variable "private_subnets" {
  description = "private subnets"
  type = map(object({
    az   = string
    cidr = string
  }))
}
