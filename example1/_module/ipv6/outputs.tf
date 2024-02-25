output "private_subnets" {
  value = {
    for k, v in var.private_subnets : k => aws_subnet.private[k].id
  }
}
