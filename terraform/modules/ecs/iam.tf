resource "aws_iam_role" "ecs_task_role_myapp" {
  name = "${local.prefix}-ecs-task-role-${local.app_name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  inline_policy {
    name = "requirements-for-ecs-exec"

    policy = jsonencode({
      Version: "2012-10-17",
      Statement: [
        {
          "Effect": "Allow",
          "Action": [
            "ssmmessages:CreateControlChannel",
            "ssmmessages:CreateDataChannel",
            "ssmmessages:OpenControlChannel",
            "ssmmessages:OpenDataChannel"
          ],
          "Resource": "*"
        }
      ]
    })
  }

}

