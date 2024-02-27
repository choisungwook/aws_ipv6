module "ipv6_only" {
  source = "../_module/ipv6_only"

  vpc_cidr   = "192.168.0.0/16"
  tag_prefix = "Example2-ipv6-only"

  public_subnets_ipv6 = {
    "1" = {
      az                 = "ap-northeast-2a",
      ipv6_subnet_netnum = 1
    }
  }

  private_subnets_ipv6 = {
    "1" = {
      az                 = "ap-northeast-2a",
      ipv6_subnet_netnum = 2
    }
  }

  public_subnets_ipv4 = {
    "1" = {
      az   = "ap-northeast-2a",
      cidr = "192.168.1.0/24"
    }
  }

  depends_on = [
    module.vpc
  ]
}

module "ipv6_only_public_nginx" {
  source = "../_module/ipv6_only_nginx_ec2"

  tag_prefix = "Example2-ipv6-public"
  vpc_id     = module.ipv6_only.vpc_id
  subnet_id  = module.ipv6_only.public_subnets_ipv6["1"]

  depends_on = [
    module.ipv6_only
  ]
}
