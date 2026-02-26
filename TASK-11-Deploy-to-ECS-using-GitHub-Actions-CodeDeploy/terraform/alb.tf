# -----------------------
# Get Default VPC
# -----------------------
data "aws_vpc" "default" {
  default = true
}

# -----------------------
# Get Subnets from Different AZs (Max 2)
# -----------------------
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Pick only first 2 unique AZ subnets
locals {
  selected_subnets = slice(data.aws_subnets.default.ids, 0, 2)
}

# -----------------------
# Security Group for ALB
# -----------------------
resource "aws_security_group" "alb_sg" {
  name        = "task11-alb-sg"
  description = "Allow HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -----------------------
# Application Load Balancer
# -----------------------
resource "aws_lb" "alb" {
  name               = "task11-izan-alb"
  load_balancer_type = "application"
  subnets            = local.selected_subnets
  security_groups    = [aws_security_group.alb_sg.id]
}

# -----------------------
# Target Group
# -----------------------
# Blue Target Group
resource "aws_lb_target_group" "tg_blue" {
  name        = "task11-izan-tg-blue"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.default.id
  target_type = "ip"

  health_check {
    path = "/"
  }
}

# Green Target Group
resource "aws_lb_target_group" "tg_green" {
  name        = "task11-izan-tg-green"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.default.id
  target_type = "ip"

  health_check {
    path = "/"
  }
}

# -----------------------
# Listener
# -----------------------
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_blue.arn
  }
}