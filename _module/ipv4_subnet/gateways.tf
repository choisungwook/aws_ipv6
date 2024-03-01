
resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.tag_prefix}"
  }
}

resource "aws_eip" "nat_gateway" {
  for_each = var.public_subnets

  domain = "vpc"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.tag_prefix}-${each.key}"
  }
}

resource "aws_nat_gateway" "main" {
  for_each = var.public_subnets

  allocation_id = aws_eip.nat_gateway[each.key].id
  subnet_id     = aws_subnet.public[each.key].id

  tags = {
    Name = "${var.tag_prefix}-${each.key}"
  }
}
