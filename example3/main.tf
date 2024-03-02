module "vpc" {
  source = "../_module/vpc"

  vpc_cidr = "192.168.0.0/16"
}

##############################
## IPv4 only
##############################

module "ipv4" {
  source = "../_module/ipv4_subnet"

  tag_prefix = "Example3-ipv4"
  vpc_id     = module.vpc.vpc_id

  public_subnets = {
    "1" = {
      az   = "ap-northeast-2a",
      cidr = "192.168.0.0/24"
    }
  }
  private_subnets = {}

  depends_on = [
    module.vpc
  ]
}

module "ipv4_public_httpserver" {
  source = "../_module/dualstack_http_sevrer"

  tag_prefix = "Example3-ipv4-public-httpserver"
  subnet_id  = module.ipv4.public_subnets["1"]
  vpc_id     = module.vpc.vpc_id

  depends_on = [
    module.ipv4
  ]
}

##############################
## IPv6 only
##############################

module "ipv6_only" {
  source = "../_module/ipv6_only"

  vpc_cidr   = "192.168.0.0/16"
  tag_prefix = "Example3-ipv6-only"

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
}

module "ipv6_only_public_httpserver" {
  source = "../_module/ipv6_only_http_server"

  tag_prefix   = "Example3-ipv6-public-httpserver"
  vpc_id       = module.ipv6_only.vpc_id
  subnet_id    = module.ipv6_only.public_subnets_ipv6["1"]
  ec2_key_name = "ipv6-test"

  depends_on = [
    module.ipv6_only
  ]
}
