resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = var.vpc_id
  availability_zone       = each.value["az"]
  cidr_block              = each.value["cidr"]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.tag_prefix}-public-${each.key}"
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = var.vpc_id
  availability_zone = each.value["az"]
  cidr_block        = each.value["cidr"]

  tags = {
    Name = "${var.tag_prefix}-private-${each.key}"
  }
}
