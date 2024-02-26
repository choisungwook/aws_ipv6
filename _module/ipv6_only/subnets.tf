resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                          = var.vpc_id
  availability_zone               = each.value["az"]
  ipv6_native                     = true
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = cidrsubnet(var.vpc_ipv6_cidr, 8, each.value["ipv6_subnet_netnum"])

  tags = {
    Name = "${var.tag_prefix}-public-${each.key}"
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id                          = var.vpc_id
  availability_zone               = each.value["az"]
  ipv6_native                     = true
  assign_ipv6_address_on_creation = true
  ipv6_cidr_block                 = cidrsubnet(var.vpc_ipv6_cidr, 8, each.value["ipv6_subnet_netnum"])

  tags = {
    Name = "${var.tag_prefix}-private-${each.key}"
  }
}
