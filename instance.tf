############################################
# Amazon Linux 2023 AMI
############################################

data "aws_ami" "amazon_linux" {
  most_recent = false

  owners = ["amazon"]

  filter {
    name   = "image-id"
    values = [var.ami_id]
  }
}

############################################
# EC2 Instance
############################################

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id = aws_subnet.public.id

  vpc_security_group_ids = [
    aws_security_group.web.id
  ]

  associate_public_ip_address = true

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data = file("${path.module}/userdata.sh")

  tags = {
    Name = "Terraform-EC2"
  }
}