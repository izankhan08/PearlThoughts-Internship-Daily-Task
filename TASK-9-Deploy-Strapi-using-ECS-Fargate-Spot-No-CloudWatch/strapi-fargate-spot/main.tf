############################
# Default VPC & Subnets
############################

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

############################
# Security Group
############################

resource "aws_security_group" "ecs_sg" {
  name   = "izan-strapi-sg-v2"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 1337
    to_port     = 1337
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

############################
# ECS Cluster
############################

resource "aws_ecs_cluster" "cluster" {
  name = "izan-strapi-cluster-v2"
}

############################
# ECS Task Definition
############################

resource "aws_ecs_task_definition" "task" {
  family                   = "izan-strapi-task-v2"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "strapi"
      image     = "054867038137.dkr.ecr.us-east-1.amazonaws.com/izan-strapi:latest"
      essential = true

      portMappings = [
        {
          containerPort = 1337
          hostPort      = 1337
        }
      ]
    }
  ])
}

############################
# ECS Service (FARGATE SPOT)
############################

resource "aws_ecs_service" "service" {
  name            = "izan-strapi-service-v2"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1

  network_configuration {
    subnets          = data.aws_subnets.default.ids
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.ecs_execution_role_policy
  ]
}