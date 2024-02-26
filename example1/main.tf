module "vpc" {
  source = "../_module/vpc"

  vpc_cidr = "192.168.0.0/16"
}

module "ipv4" {
  source = "../_module/ipv4"

  tag_prefix = "Example1-ipv4"
  vpc_id     = module.vpc.vpc_id

  public_subnets = {
    "1" = {
      az   = "ap-northeast-2a",
      cidr = "192.168.0.0/24"
    }
  }

  private_subnets = {
    "1" = {
      az   = "ap-northeast-2a",
      cidr = "192.168.1.0/24"
    }
  }

  depends_on = [
    module.vpc
  ]
}

module "ipv6_dualstack" {
  source = "../_module/ipv6_dualstack"

  tag_prefix          = "Example1-ipv6-dualstack"
  vpc_id              = module.vpc.vpc_id
  vpc_ipv6_cidr       = module.vpc.vpc_ipv6_cidr
  internet_gateway_id = module.ipv4.internet_gateway_id
  nat_gateway_ids     = module.ipv4.nat_gateway_ids

  public_subnets = {
    "1" = {
      az                 = "ap-northeast-2a",
      ipv4_cidr          = "192.168.2.0/24"
      ipv6_subnet_netnum = 1
    }
  }

  private_subnets = {
    "1" = {
      az                 = "ap-northeast-2a",
      ipv4_cidr          = "192.168.3.0/24"
      ipv6_subnet_netnum = 2
    }
  }

  depends_on = [
    module.vpc
  ]
}

module "ipv4_public_nginx" {
  source = "../_module/dualstack_nginx_ec2"

  tag_prefix = "Example1-ipv4-public"
  subnet_id  = module.ipv4.public_subnets["1"]
  vpc_id     = module.vpc.vpc_id

  depends_on = [
    module.ipv4
  ]
}

module "ipv6_dualstack_public_nginx" {
  source = "../_module/dualstack_nginx_ec2"

  tag_prefix   = "Example1-ipv6-dualstack-public"
  ipv6_enabled = true
  subnet_id    = module.ipv6_dualstack.public_subnets["1"]
  vpc_id       = module.vpc.vpc_id
  ec2_key_name = var.ipv6_dualstack_ec2_key_name

  depends_on = [
    module.ipv6_dualstack
  ]
}
