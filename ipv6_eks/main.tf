
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
    "2" = {
      az                 = "ap-northeast-2c",
      ipv4_cidr          = "192.168.3.0/24"
      ipv6_subnet_netnum = 3
    }
  }
}

module "eks" {
  source = "./_module/eks_ipv6"

  eks_cluster_name      = var.eks_cluster_name
  eks_version           = var.eks_version
  oidc_provider_enabled = true

  vpc_id                    = module.ipv6_vpc_dualstack.vpc_id
  private_subnets_ids       = module.ipv6_vpc_dualstack.private_subnets_ids
  cluster_service_ipv4_cidr = module.ipv6_vpc_dualstack.vpc_ipv4_cidr

  endpoint_prviate_access = true
  # public_access가 false이면, terraform apply를 실행한 host가 private subnet이 접근 가능해야 합니다.
  endpoint_public_access = true

  # 아래 명령어를 실행하여 addon version을 설정하세요
  # aws eks describe-addon-versions --kubernetes-version $EKS_VRESION --addon-name $ADDON_NAME --query 'addons[].addonVersions[].{Version: addonVersion, Defaultversion: compatibilities[0].defaultVersion}' --output table
  eks_addons = [
    {
      name                 = "kube-proxy"
      version              = var.addon_kube_proxy_version
      configuration_values = jsonencode({})
    },
    {
      name                 = "vpc-cni"
      version              = var.addon_vpc_cni
      configuration_values = jsonencode({})
    },
    {
      name                 = "coredns"
      version              = var.addon_coredns
      configuration_values = jsonencode({})
    }
  ]

  managed_node_groups = {
    "managed-node-group-a" = {
      node_group_name = "managed-node-group-a",
      instance_types  = ["t3.medium"],
      capacity_type   = "SPOT",
      release_version = "" #latest
      disk_size       = 20
      desired_size    = 2,
      max_size        = 2,
      min_size        = 2
    }
  }

  // irsa role 생성 여부
  karpenter_enabled      = true
  alb_controller_enabled = true
  external_dns_enabled   = true

  // aws-auth configmap 설정
  aws_auth_admin_roles = [
    var.assume_role_arn
  ]
}
