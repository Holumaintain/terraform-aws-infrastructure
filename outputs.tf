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

############################################
# EC2
############################################

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.web.id
}

output "public_ip" {
  description = "EC2 public IP"
  value       = aws_instance.web.public_ip
}

output "public_dns" {
  description = "EC2 public DNS"
  value       = aws_instance.web.public_dns
}

############################################
# Elastic IP
############################################

output "elastic_ip" {
  description = "Elastic IP address"
  value       = aws_eip.web.public_ip
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