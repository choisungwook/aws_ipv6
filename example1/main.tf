module "vpc" {
  source = "./_module/vpc"

  vpc_cidr = "192.168.0.0/16"
}

module "ipv4" {
  source = "./_module/ipv4"

  tag_prefix = "Example1-ipv4"
  vpc_id     = module.vpc.vpc_id

  public_subnets = {
    az-a = {
      az   = "ap-northeast-2a",
      cidr = "192.168.0.0/24"
    }
  }

  private_subnets = {
    az-a = {
      az   = "ap-northeast-2a",
      cidr = "192.168.1.0/24"
    }
  }

  depends_on = [
    module.vpc
  ]
}

module "ipv4_private_nginx" {
  source = "./_module/nginx_ec2"

  subnet_id  = module.ipv4.private_subnets["az-a"]
  vpc_id     = module.vpc.vpc_id
  tag_prefix = "Example1-ipv4-private"

  depends_on = [
    module.ipv4
  ]
}
