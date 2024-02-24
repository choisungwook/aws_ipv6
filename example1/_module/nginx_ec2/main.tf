resource "aws_instance" "nginx" {
  instance_type          = "t4g.nano"
  ami                    = data.aws_ami.ubuntu.id
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.nginx.id]
  iam_instance_profile   = aws_iam_instance_profile.ssm.name
  user_data              = file("${path.module}/userdata.sh")

  tags = {
    Name    = "${var.tag_prefix}-nginx"
    Project = "openvpn"
  }
}
