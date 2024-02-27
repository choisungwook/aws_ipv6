
resource "aws_route_table" "public" {
  for_each = var.public_subnets_ipv6

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.tag_prefix}-public-${each.key}"
  }
}

resource "aws_route_table" "private" {
  for_each = var.private_subnets_ipv6

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.tag_prefix}-private-${each.key}"
  }
}

resource "aws_route" "public_ipv6_internet_gateway" {
  for_each = var.public_subnets_ipv6

  route_table_id              = aws_route_table.public[each.key].id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.this.id
}

resource "aws_route" "public_nat_gateway" {
  for_each = var.public_subnets_ipv6

  route_table_id              = aws_route_table.public[each.key].id
  destination_ipv6_cidr_block = "64:ff9b::/96"
  nat_gateway_id              = aws_nat_gateway.main[each.key].id
}

resource "aws_route" "private_egress_only_gateway" {
  for_each = var.private_subnets_ipv6

  route_table_id              = aws_route_table.private[each.key].id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  for_each = var.public_subnets_ipv6

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public[each.key].id
}

resource "aws_route_table_association" "private" {
  for_each = var.private_subnets_ipv6

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}

##############################
## nat64 gateway subnet routetable
##############################

resource "aws_route_table" "public_ipv4" {
  for_each = var.public_subnets_ipv4

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.tag_prefix}-public-ipv4-${each.key}"
  }
}

resource "aws_route" "public_ipv4_internet_gateway" {
  for_each = aws_subnet.public_ipv4

  route_table_id         = aws_route_table.public_ipv4[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public_ipv4" {
  for_each = var.public_subnets_ipv4

  subnet_id      = aws_subnet.public_ipv4[each.key].id
  route_table_id = aws_route_table.public_ipv4[each.key].id
}
