locals {
  security_group_ids = var.ipv6_enabled ? [aws_security_group.httpserver.id, aws_security_group.nginx-ipv6.id] : [aws_security_group.httpserver.id]
}

resource "aws_instance" "http_server" {
  instance_type          = "t4g.medium"
  ami                    = "ami-0b56ebff00a0e5f22" # amazon linux3
  subnet_id              = var.subnet_id
  vpc_security_group_ids = local.security_group_ids
  iam_instance_profile   = aws_iam_instance_profile.ssm.name
  user_data              = file("${path.module}/userdata.sh")
  key_name               = var.ec2_key_name != null ? var.ec2_key_name : null

  tags = {
    Name = "${var.tag_prefix}-nginx"
  }
}
