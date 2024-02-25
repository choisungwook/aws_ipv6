output "vpc_id" {
  description = "vpc d"
  value       = aws_vpc.main.id
}

output "vpc_ipv6_cidr" {
  description = "vpc ipv6 cidr"
  value       = aws_vpc.main.ipv6_cidr_block
}
