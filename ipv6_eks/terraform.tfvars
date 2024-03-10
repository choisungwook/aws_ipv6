eks_cluster_name = "ipv6-eks-createby-terraform"
eks_version      = "1.29"

# VPC CNI IRSA Role ARN
# 테라폼 apply 중에 생성 됨
# 이름 규칙 - {AWS_account_ID}:role/{eks_cluster_name}-vpc-cni-irsa
vpc_cni_irsa_role_arn = "arn:aws:iam::467606240901:role/ipv6-eks-createby-terraform-vpc-cni-irsa"

// https://docs.aws.amazon.com/ko_kr/eks/latest/userguide/managing-kube-proxy.html
addon_kube_proxy_version = "v1.29.0-eksbuild.3"
// https://docs.aws.amazon.com/ko_kr/eks/latest/userguide/managing-vpc-cni.html
addon_vpc_cni = "v1.16.2-eksbuild.1"
// https://docs.aws.amazon.com/ko_kr/eks/latest/userguide/managing-coredns.html
addon_coredns = "v1.11.1-eksbuild.6"
