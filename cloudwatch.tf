############################################
# CloudWatch Alarm - EC2 CPU Utilization
############################################

resource "aws_cloudwatch_metric_alarm" "web_cpu_high" {
  alarm_name          = "${var.project_name}-web-cpu-high"
  alarm_description   = "Alarm when EC2 CPU utilization is too high"
  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 2
  period             = 300

  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"
  statistic   = "Average"

  threshold = 70

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web.name
  }

  alarm_actions = [
    aws_autoscaling_policy.scale_out.arn
  ]

  tags = {
    Name = "Terraform-Web-CPU-Alarm"
  }
}

############################################
# CloudWatch Alarm - EC2 CPU Low
############################################

resource "aws_cloudwatch_metric_alarm" "web_cpu_low" {
  alarm_name          = "${var.project_name}-web-cpu-low"
  alarm_description   = "Alarm when EC2 CPU utilization is too low"
  comparison_operator = "LessThanThreshold"

  evaluation_periods = 2
  period             = 300

  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"
  statistic   = "Average"

  threshold = 30

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web.name
  }

  alarm_actions = [
    aws_autoscaling_policy.scale_in.arn
  ]

  tags = {
    Name = "Terraform-Web-CPU-Low-Alarm"
  }
}