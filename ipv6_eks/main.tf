
module "ipv6_vpc_dualstack" {
  source = "./_module/eks_ipv6_vpc"

  tag_prefix = "EKS-ipv6-dualstack"
  vpc_cidr   = "192.168.0.0/16"

  public_subnets = {
    "1" = {
      az                 = "ap-northeast-2a",
      ipv4_cidr          = "192.168.0.0/24"
      ipv6_subnet_netnum = 0
    }
    "2" = {
      az                 = "ap-northeast-2c",
      ipv4_cidr          = "192.168.1.0/24"
      ipv6_subnet_netnum = 1
    }
  }

  private_subnets = {
    "1" = {
      az                 = "ap-northeast-2a",
      ipv4_cidr          = "192.168.2.0/24"
      ipv6_subnet_netnum = 2
    }
    "1" = {
      az                 = "ap-northeast-2c",
      ipv4_cidr          = "192.168.3.0/24"
      ipv6_subnet_netnum = 3
    }
  }
}

# module "ipv6_only" {
#   source = "../_module/ipv6_only"

#   tag_prefix          = "Example2-ipv6-only"
#   vpc_id              = module.vpc.vpc_id
#   vpc_ipv6_cidr       = module.vpc.vpc_ipv6_cidr

#   public_subnets = {
#     "1" = {
#       az                 = "ap-northeast-2a",
#       ipv6_subnet_netnum = 1
#     }
#   }

#   private_subnets = {
#     "1" = {
#       az                 = "ap-northeast-2a",
#       ipv6_subnet_netnum = 2
#     }
#   }

#   depends_on = [
#     module.vpc
#   ]
# }

# # module "ipv4_public_nginx" {
# #   source = "../_module/only_nginx_ec2"

# #   tag_prefix = "Example2-ipv4-public"
# #   subnet_id  = module.ipv4.public_subnets["1"]
# #   vpc_id     = module.vpc.vpc_id

# #   depends_on = [
# #     module.ipv4
# #   ]
# # }

# module "ipv6_only_public_nginx" {
#   source = "../_module/ipv6_only_nginx_ec2"

#   tag_prefix   = "Example2-ipv6-only-public"
#   ipv6_enabled = true
#   subnet_id    = module.ipv6_only.public_subnets["1"]
#   vpc_id       = module.vpc.vpc_id

#   depends_on = [
#     module.ipv6_only
#   ]
# }
