# EKS Additional security group
resource "aws_security_group" "cluster" {
  name        = "eks-cluster-${var.eks_cluster_name}"
  description = "Default SG to allow traffic from the EKS"
  vpc_id      = var.vpc_id

  ################################################################################
  # IPv4
  ################################################################################

  ingress {
    description = "Allow self"
    self        = true
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = []
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ################################################################################
  # IPv6
  ################################################################################

  ingress {
    description      = "Allow self"
    self             = true
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    ipv6_cidr_blocks = []
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.eks_cluster_name}-cluster-sg"
  }
}
