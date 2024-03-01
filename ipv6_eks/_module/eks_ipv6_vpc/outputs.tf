output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_ipv4_cidr" {
  value = aws_vpc.main.cidr_block
}

output "vpc_ipv6_cidr" {
  value = aws_vpc.main.ipv6_cidr_block
}

output "private_subnets_ids" {
  value = [for private_subnet in aws_subnet.private : private_subnet.id]
}
