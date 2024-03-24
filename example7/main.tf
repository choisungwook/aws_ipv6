#####################
### VPC1
#####################

module "vpc" {
  source = "../_module/vpc"

  tag_prefix = "Example7"
  vpc_cidr   = "192.168.0.0/16"
}

module "ipv4" {
  source = "../_module/ipv4_subnet"

  tag_prefix = "Example7-ipv4"
  vpc_id     = module.vpc.vpc_id

  public_subnets = {
    "1" = {
      az   = "ap-northeast-2a",
      cidr = "192.168.0.0/24"
    },
    "2" = {
      az   = "ap-northeast-2c",
      cidr = "192.168.30.0/24"
    }
  }

  private_subnets = {
    "1" = {
      az   = "ap-northeast-2a",
      cidr = "192.168.1.0/24"
    },
    "2" = {
      az   = "ap-northeast-2c",
      cidr = "192.168.31.0/24"
    }
  }
}

module "ipv6_dualstack" {
  source = "../_module/ipv6_dualstack"

  tag_prefix          = "Example7-ipv6-dualstack"
  vpc_id              = module.vpc.vpc_id
  vpc_ipv6_cidr       = module.vpc.vpc_ipv6_cidr
  internet_gateway_id = module.ipv4.internet_gateway_id
  nat_gateway_ids     = module.ipv4.nat_gateway_ids

  public_subnets = {
    "1" = {
      az                 = "ap-northeast-2a",
      ipv4_cidr          = "192.168.2.0/24"
      ipv6_subnet_netnum = 1
    },
    "2" = {
      az                 = "ap-northeast-2c",
      ipv4_cidr          = "192.168.10.0/24"
      ipv6_subnet_netnum = 3
    }
  }

  private_subnets = {
    "1" = {
      az                 = "ap-northeast-2a",
      ipv4_cidr          = "192.168.3.0/24"
      ipv6_subnet_netnum = 2
    },
    "2" = {
      az                 = "ap-northeast-2c",
      ipv4_cidr          = "192.168.13.0/24"
      ipv6_subnet_netnum = 4
    }
  }
}

module "ipv6_dualstack_nginx" {
  source = "../_module/dualstack_nginx_ec2_with_alb"

  tag_prefix   = "Example7-ipv6-dualstack"
  ipv6_enabled = true
  subnet_ids   = [for k, v in module.ipv6_dualstack.public_subnets : v]
  vpc_id       = module.vpc.vpc_id
  ec2_key_name = var.ipv6_dualstack_ec2_key_name
  internal     = false

  depends_on = [
    module.ipv6_dualstack
  ]
}
