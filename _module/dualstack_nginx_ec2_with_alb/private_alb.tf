resource "aws_lb" "private_alb" {
  name                             = "${var.tag_prefix}-int"
  internal                         = true
  load_balancer_type               = "application"
  subnets                          = var.subnet_ids
  enable_cross_zone_load_balancing = true
  enable_deletion_protection       = false
  enable_http2                     = true
  security_groups                  = [aws_security_group.private_alb.id]
  ip_address_type                  = "dualstack"

  tags = {
    Name = "${var.tag_prefix}-nginx"
  }
}

resource "aws_lb_listener" "nginx_ipv6" {
  load_balancer_arn = aws_lb.private_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private.arn
  }
}


resource "aws_lb_target_group" "private" {
  name        = "nginx-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  tags = {
    Name = "${var.tag_prefix}-nginx"
  }
}

resource "aws_lb_target_group_attachment" "private" {
  target_group_arn = aws_lb_target_group.private.arn
  target_id        = aws_instance.nginx.id
  port             = 80
}
