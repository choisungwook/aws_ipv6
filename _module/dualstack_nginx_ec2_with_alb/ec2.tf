locals {
  security_group_ids = var.ipv6_enabled ? [aws_security_group.nginx-ipv4.id, aws_security_group.nginx-ipv6.id] : [aws_security_group.nginx-ipv4.id]
}

resource "aws_instance" "nginx" {
  instance_type          = "t4g.nano"
  ami                    = "ami-0baf474c04c731d22" # or data.aws_ami.ubuntu.id
  subnet_id              = var.subnet_ids[0]
  vpc_security_group_ids = local.security_group_ids
  iam_instance_profile   = aws_iam_instance_profile.ssm.name
  user_data              = file("${path.module}/userdata.sh")
  key_name               = var.ec2_key_name != null ? var.ec2_key_name : null

  tags = {
    Name = "${var.tag_prefix}-nginx"
  }
}
