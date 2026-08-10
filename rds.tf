############################################
# RDS DB Subnet Group
############################################

resource "aws_db_subnet_group" "mysql" {
  name = "terraform-mysql-subnet-group"

  subnet_ids = [
    aws_subnet.private.id,
    aws_subnet.private_a.id
  ]

  tags = {
    Name = "Terraform-MySQL-Subnet-Group"
  }
}

############################################
# RDS MySQL Instance
############################################

resource "aws_db_instance" "mysql" {
  identifier = "terraform-mysql"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = "terraformdb"
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.mysql.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  publicly_accessible = false

  skip_final_snapshot = true

  tags = {
    Name = "Terraform-MySQL"
  }
}