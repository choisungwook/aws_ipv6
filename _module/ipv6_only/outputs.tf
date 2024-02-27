output "vpc_id" {
  description = "vpc d"
  value       = aws_vpc.main.id
}

output "private_subnets_ipv6" {
  value = {
    for k, v in var.private_subnets_ipv6 : k => aws_subnet.private[k].id
  }
}

output "public_subnets_ipv6" {
  value = {
    for k, v in var.public_subnets_ipv6 : k => aws_subnet.public[k].id
  }
}
