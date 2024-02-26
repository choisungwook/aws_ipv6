
resource "aws_route_table" "public" {
  for_each = var.public_subnets

  vpc_id = var.vpc_id

  tags = {
    Name = "${var.tag_prefix}-public-${each.key}"
  }
}

resource "aws_route_table" "private" {
  for_each = var.private_subnets

  vpc_id = var.vpc_id

  tags = {
    Name = "${var.tag_prefix}-private-${each.key}"
  }
}

resource "aws_route" "public_ipv4_internet_gateway" {
  for_each = var.public_subnets

  route_table_id         = aws_route_table.public[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}

resource "aws_route" "public_ipv6_internet_gateway" {
  for_each = var.public_subnets

  route_table_id              = aws_route_table.public[each.key].id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = var.internet_gateway_id
}

resource "aws_route" "private_nat_gateway" {
  for_each = var.private_subnets

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_gateway_ids[each.key]
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public[each.key].id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}
