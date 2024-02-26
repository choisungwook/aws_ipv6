resource "aws_egress_only_internet_gateway" "this" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.tag_prefix}"
  }
}
