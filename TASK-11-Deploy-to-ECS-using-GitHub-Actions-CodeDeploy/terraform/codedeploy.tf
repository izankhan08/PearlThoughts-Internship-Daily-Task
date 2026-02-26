# -----------------------
# CodeDeploy Application
# -----------------------
resource "aws_codedeploy_app" "ecs_app" {
  name             = "task11-izan-app"
  compute_platform = "ECS"
}

# -----------------------
# CodeDeploy Deployment Group
# -----------------------
resource "aws_codedeploy_deployment_group" "ecs_dg" {
  app_name              = aws_codedeploy_app.ecs_app.name
  deployment_group_name = "task11-izan-dg"
  service_role_arn      = "arn:aws:iam::811738710312:role/codedeploy_role"

  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"

  deployment_style {
    deployment_type   = "BLUE_GREEN"
    deployment_option = "WITH_TRAFFIC_CONTROL"
  }

  blue_green_deployment_config {
    terminate_blue_instances_on_deployment_success {
      action = "TERMINATE"
      termination_wait_time_in_minutes = 1
    }

    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }
  }

  ecs_service {
    cluster_name = aws_ecs_cluster.cluster.name
    service_name = aws_ecs_service.service.name
  }

  load_balancer_info {
    target_group_pair_info {
      target_group {
        name = aws_lb_target_group.tg_blue.name
      }

      target_group {
        name = aws_lb_target_group.tg_green.name
      }

      prod_traffic_route {
        listener_arns = [aws_lb_listener.listener.arn]
      }
    }
  }
}