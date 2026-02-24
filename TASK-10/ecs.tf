resource "aws_ecs_cluster" "cluster" {
  name = "task10-cluster"
}

resource "aws_ecs_task_definition" "task" {
  family                   = "task10-strapi"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = "arn:aws:iam::811738710312:role/ecs_fargate_taskRole"

  container_definitions = jsonencode([
    {
      name  = "strapi"
      image = "nginx:latest"
      portMappings = [{
        containerPort = 80
        protocol      = "tcp"
      }]
    }
  ])
}

resource "aws_ecs_service" "service" {
  name            = "task10-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [
      "subnet-0cc23dc8400d81bf3",
      "subnet-00efaeabe6a244f6f"
    ]
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.blue.arn
    container_name   = "strapi"
    container_port   = 80
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }
}