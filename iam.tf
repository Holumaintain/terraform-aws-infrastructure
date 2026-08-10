############################################
# EC2 IAM Role
############################################

resource "aws_iam_role" "ec2_role" {
  name = "Terraform-EC2-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

############################################
# SSM Managed Policy
############################################

resource "aws_iam_role_policy_attachment" "ssm" {
  role = aws_iam_role.ec2_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

############################################
# EC2 Instance Profile
############################################

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "Terraform-InstanceProfile"

  role = aws_iam_role.ec2_role.name
}

############################################
# S3 IAM Policy
############################################

resource "aws_iam_policy" "s3_access" {
  name = "Terraform-S3-Access"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:ListBucket"
        ]

        Resource = aws_s3_bucket.app_bucket.arn
      },

      {
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]

        Resource = "${aws_s3_bucket.app_bucket.arn}/*"
      }
    ]
  })
}

############################################
# Attach S3 Policy to EC2 Role
############################################

resource "aws_iam_role_policy_attachment" "s3_access" {
  role = aws_iam_role.ec2_role.name

  policy_arn = aws_iam_policy.s3_access.arn
}