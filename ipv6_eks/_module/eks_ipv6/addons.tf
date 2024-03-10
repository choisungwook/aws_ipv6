resource "aws_eks_addon" "addons" {
  for_each = { for addon in var.eks_addons : addon.name => addon }

  cluster_name             = aws_eks_cluster.main.id
  addon_name               = each.value.name
  addon_version            = each.value.version
  configuration_values     = each.value.configuration_values
  service_account_role_arn = each.value.service_account_role_arn

  timeouts {
    create = try(each.value.timeouts.create, "5m", null)
    update = try(each.value.timeouts.update, "5m", null)
    delete = try(each.value.timeouts.delete, "5m", null)
  }

  depends_on = [
    aws_eks_node_group.main,
    aws_iam_role_policy_attachment.cni_ipv4_to_node_group,
    aws_iam_role_policy_attachment.cni_ipv4_to_vpc_cni,
    aws_iam_role_policy_attachment.cni_ipv6_to_node_group,
    aws_iam_role_policy_attachment.cni_ipv6_to_vpc_cni
  ]
}
