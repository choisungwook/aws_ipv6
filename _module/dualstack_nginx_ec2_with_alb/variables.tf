variable "tag_prefix" {
  description = "tag prefix"
  type        = string
  default     = "Example1"
}

variable "vpc_id" {
  description = "id"
  type        = string
}

variable "subnet_ids" {
  description = "subnets ids"
  type        = list(string)
}

variable "ec2_key_name" {
  description = "ec2 key name"
  type        = string
  default     = null
}

variable "ipv6_enabled" {
  description = "ipv6 enabled"
  type        = bool
  default     = false
}
