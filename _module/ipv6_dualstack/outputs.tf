output "private_subnets" {
  value = {
    for k, v in var.private_subnets : k => aws_subnet.private[k].id
  }
}

output "public_subnets" {
  value = {
    for k, v in var.public_subnets : k => aws_subnet.public[k].id
  }
}
