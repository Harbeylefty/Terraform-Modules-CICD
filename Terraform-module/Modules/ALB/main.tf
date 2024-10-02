// create load balancer
resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids
}

// create lb target group 
resource "aws_lb_target_group" "target_alb" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/health"
    port = 80
    protocol = "HTTP"
  }
}

// Create lb target group attachment
resource "aws_lb_target_group_attachment" "alb_tga" {
  count = length(var.instance_ids)
  target_group_arn = aws_lb_target_group.target_alb.arn
  target_id        = var.instance_ids[count.index]
  port             = 80
  depends_on = [aws_lb_target_group.target_alb]
}

// create listener 
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_alb.arn
  }
}

