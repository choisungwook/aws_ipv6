variable "tag_prefix" {
  description = "tag prefix"
  type        = string
  default     = "Example1"
}

variable "vpc_id" {
  description = "id"
  type        = string
}

variable "subnet_id" {
  description = "subnets id"
  type        = string
}

variable "spot_instance_type" {
  description = "spot instance type"
  type        = string
  default     = "t4g.nano"
}

variable "spot_type" {
  description = "spot type"
  type        = string
  default     = "one-time"

}

variable "spot_price" {
  description = "spot price"
  type        = string
  default     = "0.01"
}
