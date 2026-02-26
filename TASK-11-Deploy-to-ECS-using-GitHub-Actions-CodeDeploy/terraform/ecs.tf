resource "aws_ecs_cluster" "cluster" {
  name = "task11-izan-cluster"
}

resource "aws_ecs_task_definition" "task" {
  family                   = "task11-izan-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = "arn:aws:iam::811738710312:role/ecs_fargate_taskRole"

  container_definitions = jsonencode([
    {
      name      = "task11-container"
      image     = "nginx"
      essential = true
      portMappings = [{
        containerPort = 80
        hostPort      = 80
      }]
    }
  ])
}