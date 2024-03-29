variable "tag_prefix" {
  description = "tag prefix"
  type        = string
  default     = "Example1-ipv6only"
}

variable "vpc_id" {
  description = "id"
  type        = string
}

variable "subnet_id" {
  description = "subnets id"
  type        = string
}

variable "ec2_key_name" {
  description = "ec2 key name"
  type        = string
  default     = null
}
