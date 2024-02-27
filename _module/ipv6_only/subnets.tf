resource "aws_subnet" "public" {
  for_each = var.public_subnets_ipv6

  vpc_id                                         = aws_vpc.main.id
  availability_zone                              = each.value["az"]
  ipv6_native                                    = true
  assign_ipv6_address_on_creation                = true
  enable_dns64                                   = true
  enable_resource_name_dns_aaaa_record_on_launch = true
  ipv6_cidr_block                                = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, each.value["ipv6_subnet_netnum"])

  tags = {
    Name = "${var.tag_prefix}-public-${each.key}"
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets_ipv6

  vpc_id                                         = aws_vpc.main.id
  availability_zone                              = each.value["az"]
  ipv6_native                                    = true
  assign_ipv6_address_on_creation                = true
  enable_dns64                                   = true
  enable_resource_name_dns_aaaa_record_on_launch = true
  ipv6_cidr_block                                = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, each.value["ipv6_subnet_netnum"])

  tags = {
    Name = "${var.tag_prefix}-private-${each.key}"
  }
}


##############################
## nat64 gateway subnet
##############################

resource "aws_subnet" "public_ipv4" {
  for_each = var.public_subnets_ipv4

  vpc_id                  = aws_vpc.main.id
  availability_zone       = each.value["az"]
  cidr_block              = each.value["cidr"]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.tag_prefix}-public-ipv4-${each.key}"
  }
}
