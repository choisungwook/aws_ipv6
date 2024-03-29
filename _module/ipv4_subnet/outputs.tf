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

output "internet_gateway_id" {
  value = aws_internet_gateway.main.id
}

output "nat_gateway_ids" {
  value = {
    for k, v in aws_nat_gateway.main : k => v.id
  }
}
