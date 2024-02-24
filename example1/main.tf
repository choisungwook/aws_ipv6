module "vpc" {
  source = "./_module/vpc"

  vpc_cidr = "192.168.0.0/16"
}

module "ipv4" {
  source = "./_module/ipv4"

  vpc_id = module.vpc.vpc_id

  public_subnets = {
    public-a = {
      az   = "ap-northeast-2a",
      cidr = "192.168.0.0/24"
    }
  }

  private_subnets = {
    private-a = {
      az   = "ap-northeast-2a",
      cidr = "192.168.1.0/24"
    }
  }

  depends_on = [
    module.vpc
  ]
}
