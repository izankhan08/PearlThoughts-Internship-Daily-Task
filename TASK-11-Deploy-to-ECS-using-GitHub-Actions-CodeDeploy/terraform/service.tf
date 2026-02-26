resource "aws_ecs_service" "service" {
  name            = "task11-izan-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  # 🔥 VERY IMPORTANT FOR CODEDEPLOY
  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets          = local.selected_subnets
    assign_public_ip = true
    security_groups  = [aws_security_group.alb_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg_blue.arn
    container_name   = "task11-container"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.listener]
}