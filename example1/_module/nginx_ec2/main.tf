resource "aws_spot_instance_request" "nginx" {
  ami                  = data.aws_ami.ubuntu.id
  spot_price           = var.spot_price
  instance_type        = var.spot_instance_type
  spot_type            = var.spot_type
  wait_for_fulfillment = "true"
  user_data            = file("${path.module}/userdata.sh")
  security_groups      = [aws_security_group.nginx.id]
  subnet_id            = var.subnet_id

  tags = {
    Name = "${var.tag_prefix}-nginx"
  }
}
