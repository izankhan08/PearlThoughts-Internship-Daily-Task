resource "aws_lb" "app_alb" {
  name               = "izan-task10-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]

  subnets = [
    "subnet-0cc23dc8400d81bf3", # us-east-1a
    "subnet-00efaeabe6a244f6f"  # us-east-1b
  ]
}

resource "aws_lb_target_group" "blue" {
  name        = "izan-blue"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "vpc-0778ad9a2069279fc"
  target_type = "ip"

  health_check {
    path                = "/"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group" "green" {
  name        = "izan-green"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "vpc-0778ad9a2069279fc"
  target_type = "ip"

  health_check {
    path                = "/"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }
}