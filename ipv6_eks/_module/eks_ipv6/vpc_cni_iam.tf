resource "aws_iam_role" "vpc_cni_irsa" {
  name               = "${var.eks_cluster_name}-vpc-cni-irsa"
  assume_role_policy = data.aws_iam_policy_document.vpc_cni_irsa_assume_role_policy.json
  tags = {
    eks = "${var.eks_cluster_name}-irsa"
  }
}

data "aws_iam_policy_document" "vpc_cni_irsa_assume_role_policy" {
  version = "2012-10-17"
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.main.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.main.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }
  }
}

# IPv4 CNI Policy
resource "aws_iam_role_policy_attachment" "cni_ipv4_to_node_group" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_group_role.id
}

# IPv4 CNI Policy
resource "aws_iam_role_policy_attachment" "cni_ipv4_to_vpc_cni" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.vpc_cni_irsa.id
}


################################################################################
# EKS IPV6 CNI Policy
# https://docs.aws.amazon.com/eks/latest/userguide/cni-iam-role.html#cni-iam-role-create-ipv6-policy
################################################################################

# Note - we are keeping this to a minimum in hopes that its soon replaced with an AWS managed policy like `AmazonEKS_CNI_Policy`
resource "aws_iam_policy" "cni_ipv6_policy" {
  # Will cause conflicts if trying to create on multiple clusters but necessary to reference by exact name in sub-modules
  name        = "${var.eks_cluster_name}-AmazonEKS_CNI_IPv6_Policy"
  description = "IAM policy for EKS CNI to assign IPV6 addresses"
  policy      = data.aws_iam_policy_document.cni_ipv6_policy.json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "cni_ipv6_policy" {
  statement {
    sid = "AssignDescribe"
    actions = [
      "ec2:AssignIpv6Addresses",
      "ec2:DescribeInstances",
      "ec2:DescribeTags",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeInstanceTypes"
    ]
    resources = ["*"]
  }

  statement {
    sid       = "CreateTags"
    actions   = ["ec2:CreateTags"]
    resources = ["arn:aws:ec2:*:*:network-interface/*"]
  }
}

# todo - Worker node에 policy가 없어도 되는지 확인 필요
# IPv6 CNI Policy
resource "aws_iam_role_policy_attachment" "cni_ipv6_to_node_group" {
  role       = aws_iam_role.node_group_role.id
  policy_arn = aws_iam_policy.cni_ipv6_policy.arn
}

# IPv6 CNI Policy
resource "aws_iam_role_policy_attachment" "cni_ipv6_to_vpc_cni" {
  role       = aws_iam_role.vpc_cni_irsa.id
  policy_arn = aws_iam_policy.cni_ipv6_policy.arn
}
