############################################
# Elastic IP
############################################

resource "aws_eip" "web" {
  domain = "vpc"

  tags = {
    Name = "Terraform-EIP"
  }
}

############################################
# Elastic IP Association
############################################

resource "aws_eip_association" "web" {
  instance_id   = aws_instance.web.id
  allocation_id = aws_eip.web.id
}