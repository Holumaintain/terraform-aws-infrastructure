############################################
# VPC
############################################

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

############################################
# Subnets
############################################

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "Private subnet ID"
  value       = aws_subnet.private.id
}

output "private_subnet_a_id" {
  description = "Second private subnet ID"
  value       = aws_subnet.private_a.id
}

############################################
# Security Groups
############################################

output "security_group_id" {
  description = "Web security group ID"
  value       = aws_security_group.web.id
}

output "rds_security_group_id" {
  description = "RDS security group ID"
  value       = aws_security_group.rds.id
}

output "alb_security_group_id" {
  description = "ALB security group ID"
  value       = aws_security_group.alb.id
}

############################################
# Application Load Balancer
############################################

output "alb_dns_name" {
  description = "Application Load Balancer DNS name"
  value       = aws_lb.web.dns_name
}

output "alb_arn" {
  description = "Application Load Balancer ARN"
  value       = aws_lb.web.arn
}

############################################
# Auto Scaling Group
############################################

output "autoscaling_group_name" {
  description = "Auto Scaling Group name"
  value       = aws_autoscaling_group.web.name
}

############################################
# Launch Template
############################################

output "launch_template_id" {
  description = "Launch Template ID"
  value       = aws_launch_template.web.id
}

############################################
# Target Group
############################################

output "target_group_arn" {
  description = "ALB target group ARN"
  value       = aws_lb_target_group.web.arn
}

############################################
# S3
############################################

output "s3_bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.app_bucket.bucket
}

############################################
# RDS
############################################

output "rds_endpoint" {
  description = "RDS MySQL endpoint"
  value       = aws_db_instance.mysql.endpoint
}

output "rds_address" {
  description = "RDS MySQL hostname"
  value       = aws_db_instance.mysql.address
}