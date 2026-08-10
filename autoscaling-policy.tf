############################################
# Auto Scaling Policy - Scale Out
############################################

resource "aws_autoscaling_policy" "scale_out" {
  name                   = "${var.project_name}-scale-out"
  autoscaling_group_name = aws_autoscaling_group.web.name

  policy_type = "SimpleScaling"

  adjustment_type    = "ChangeInCapacity"
  scaling_adjustment = 1
  cooldown           = 300
}