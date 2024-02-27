resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.tag_prefix}"
  }
}

resource "aws_egress_only_internet_gateway" "this" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.tag_prefix}"
  }
}

resource "aws_eip" "nat_gateway" {
  for_each = var.public_subnets_ipv6

  domain = "vpc"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.tag_prefix}-${each.key}"
  }
}

// nat64 gateway
resource "aws_nat_gateway" "main" {
  for_each = var.public_subnets_ipv4

  allocation_id = aws_eip.nat_gateway[each.key].id
  subnet_id     = aws_subnet.public_ipv4[each.key].id

  tags = {
    Name = "${var.tag_prefix}-${each.key}"
  }
}
