resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id            = aws_vpc.main.id
  availability_zone = each.value["az"]

  // IPv4
  cidr_block              = each.value["ipv4_cidr"]
  map_public_ip_on_launch = true

  // IPv6
  assign_ipv6_address_on_creation                = true
  enable_dns64                                   = true
  enable_resource_name_dns_aaaa_record_on_launch = true
  ipv6_cidr_block                                = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, each.value["ipv6_subnet_netnum"])

  tags = {
    Name                                            = "${var.tag_prefix}-public-${each.key}"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                        = "1"
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.main.id
  availability_zone = each.value["az"]

  // IPv4
  cidr_block              = each.value["ipv4_cidr"]
  map_public_ip_on_launch = true

  // IPv6
  assign_ipv6_address_on_creation                = true
  enable_dns64                                   = true
  enable_resource_name_dns_aaaa_record_on_launch = true
  ipv6_cidr_block                                = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, each.value["ipv6_subnet_netnum"])

  tags = {
    Name                                            = "${var.tag_prefix}-private-${each.key}"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"               = "1"
    "karpenter.sh/discovery"                        = "${var.eks_cluster_name}"
  }
}
