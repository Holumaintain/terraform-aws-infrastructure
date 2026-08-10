############################################
# Launch Template
############################################

resource "aws_launch_template" "web" {
  name_prefix   = "terraform-web-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  vpc_security_group_ids = [
    aws_security_group.web.id
  ]

  user_data = filebase64("${path.module}/userdata.sh")

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Terraform-ASG-Web"
    }
  }
}

############################################
# Auto Scaling Group
############################################

resource "aws_autoscaling_group" "web" {
  name = "terraform-web-asg"

  min_size         = 1
  max_size         = 2
  desired_capacity = 1

  vpc_zone_identifier = [
    aws_subnet.public.id
  ]

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  target_group_arns = [
    aws_lb_target_group.web.arn
  ]

  health_check_type         = "ELB"
  health_check_grace_period = 120

  tag {
    key                 = "Name"
    value               = "Terraform-ASG-Web"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

############################################
# Auto Scaling Policy - Scale In
############################################

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "${var.project_name}-scale-in"
  autoscaling_group_name = aws_autoscaling_group.web.name
  policy_type            = "SimpleScaling"

  adjustment_type    = "ChangeInCapacity"
  scaling_adjustment = -1
  cooldown           = 300
}