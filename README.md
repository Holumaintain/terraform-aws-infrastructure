# Terraform AWS Infrastructure

A production-style AWS infrastructure project built with **Terraform** using Infrastructure as Code (IaC).

This project demonstrates how to provision, configure, monitor, and manage a complete AWS environment programmatically instead of creating resources manually through the AWS Management Console.

## 🏗️ Architecture

The infrastructure includes:

* Amazon VPC
* Public and private subnets
* Internet Gateway
* Route tables
* Security Groups
* Amazon EC2
* Elastic IP
* IAM Role and Instance Profile
* Amazon S3
* Amazon RDS MySQL
* Application Load Balancer
* Auto Scaling Group
* Launch Template
* Auto Scaling Policies
* Amazon CloudWatch
* Terraform Outputs

### High-Level Architecture

```text
                         Internet
                            |
                            v
                 +---------------------+
                 | Application Load    |
                 | Balancer (ALB)      |
                 +----------+----------+
                            |
                 +----------+----------+
                 |                     |
                 v                     v
          +-------------+       +-------------+
          | EC2 Instance|       | EC2 Instance|
          | / ASG       |       | / ASG       |
          +------+------+       +------+------+
                 |                     |
                 +----------+----------+
                            |
                            v
                    +---------------+
                    |   RDS MySQL   |
                    +---------------+

                    +---------------+
                    |   Amazon S3   |
                    +---------------+

                    +---------------+
                    |   CloudWatch  |
                    +---------------+
```

## 🚀 Technologies Used

| Technology   | Purpose                        |
| ------------ | ------------------------------ |
| Terraform    | Infrastructure as Code         |
| AWS          | Cloud infrastructure           |
| EC2          | Compute                        |
| VPC          | Networking                     |
| RDS MySQL    | Relational database            |
| S3           | Object storage                 |
| ALB          | Load balancing                 |
| Auto Scaling | Application scalability        |
| IAM          | Identity and access management |
| CloudWatch   | Monitoring and alarms          |
| Git          | Version control                |
| GitHub       | Source code management         |

## 📁 Project Structure

```text
Terraform-Demo/
│
├── .gitignore
├── Provider.tf
├── backend.tf
├── main.tf
├── variables.tf
├── outputs.tf
│
├── networking.tf
├── security.tf
├── instance.tf
├── eip.tf
│
├── iam.tf
├── s3.tf
├── rds.tf
│
├── alb.tf
├── asg.tf
├── autoscaling-policy.tf
├── cloudwatch.tf
│
├── userdata.sh
└── README.md
```

### File Descriptions

**Provider.tf**
Configures the AWS provider and Terraform version/provider requirements.

**backend.tf**
Contains Terraform backend configuration.

**main.tf**
Contains the main Terraform infrastructure configuration.

**networking.tf**
Creates the VPC, subnets, Internet Gateway, route tables, and networking components.

**security.tf**
Defines security groups and network access rules.

**instance.tf**
Creates and configures the EC2 instance.

**eip.tf**
Creates and associates an Elastic IP.

**iam.tf**
Creates the EC2 IAM role, instance profile, and required policies.

**s3.tf**
Creates the S3 bucket and access policy.

**rds.tf**
Creates the MySQL RDS database and database subnet group.

**alb.tf**
Creates the Application Load Balancer, target group, and listener.

**asg.tf**
Creates the Auto Scaling Group and Launch Template.

**autoscaling-policy.tf**
Defines scale-out and scale-in policies.

**cloudwatch.tf**
Creates CloudWatch monitoring and CPU alarms.

**variables.tf**
Defines configurable Terraform variables.

**outputs.tf**
Displays useful infrastructure information after deployment.

**userdata.sh**
Bootstraps the EC2 instance and installs/configures Apache HTTP Server.

## ⚙️ Prerequisites

Before running this project, install:

* Terraform
* AWS CLI
* Git

You also need:

* An AWS account
* AWS credentials configured locally
* An AWS IAM user/role with sufficient permissions
* An existing EC2 key pair if the configuration requires SSH access

Verify Terraform:

```bash
terraform version
```

Verify AWS CLI:

```bash
aws --version
```

Verify AWS authentication:

```bash
aws sts get-caller-identity
```

## 🔐 AWS Authentication

Configure your AWS credentials using the AWS CLI:

```bash
aws configure
```

You will be prompted for:

```text
AWS Access Key ID
AWS Secret Access Key
Default region name
Default output format
```

Do not commit AWS access keys, secret keys, `.tfvars` files containing secrets, private keys, or Terraform state files to GitHub.

## 🛠️ Terraform Workflow

Initialize the Terraform project:

```bash
terraform init
```

Format the Terraform files:

```bash
terraform fmt -recursive
```

Validate the configuration:

```bash
terraform validate
```

Create an execution plan:

```bash
terraform plan
```

Apply the infrastructure:

```bash
terraform apply
```

Terraform will ask for confirmation before creating the infrastructure.

To automatically approve:

```bash
terraform apply -auto-approve
```

## 📤 View Outputs

After deployment:

```bash
terraform output
```

You can also retrieve a specific output:

```bash
terraform output public_ip
```

## 🌐 Testing the Web Server

After Terraform completes successfully, retrieve the public IP:

```bash
terraform output public_ip
```

Then open the IP address in a web browser.

The EC2 instance is configured to install Apache and serve:

```text
Welcome to Terraform on AWS!
```

If an Application Load Balancer is configured, use its DNS name to access the application.

## 📊 Monitoring

Amazon CloudWatch is used to monitor the infrastructure.

The project includes CPU-based Auto Scaling alarms for:

* High CPU utilization
* Low CPU utilization

These alarms can trigger the configured Auto Scaling policies.

## 🔄 Auto Scaling

The Auto Scaling Group allows EC2 capacity to automatically adjust according to application demand.

The project includes:

* Launch Template
* Minimum capacity
* Maximum capacity
* Desired capacity
* Scale-out policy
* Scale-in policy
* CloudWatch alarms

This demonstrates horizontal scaling using AWS infrastructure.

## 🗄️ Database

The project provisions an Amazon RDS MySQL database.

The database is placed in private networking and protected using a dedicated security group.

MySQL traffic is restricted to the appropriate application/web security group on port:

```text
3306
```

## 🪣 S3

The project provisions an Amazon S3 bucket for object storage.

An IAM policy provides the EC2 role with permissions for:

```text
s3:ListBucket
s3:GetObject
s3:PutObject
s3:DeleteObject
```

This demonstrates how AWS IAM can provide applications with controlled access to AWS services without embedding AWS credentials inside the application.

## 🔒 Security Considerations

This project demonstrates several AWS security practices:

* IAM roles instead of hard-coded AWS credentials
* Separate security groups for different infrastructure components
* Private subnets for backend resources
* Restricted database access
* SSM Managed Instance Core policy for EC2 management
* Terraform-managed infrastructure
* Sensitive Terraform files excluded through `.gitignore`

For production environments, additional security controls should be considered, including:

* AWS Secrets Manager
* AWS Systems Manager Parameter Store
* HTTPS/TLS certificates
* AWS WAF
* CloudTrail
* VPC Flow Logs
* More restrictive security group rules
* Encryption at rest
* Encryption in transit
* Least-privilege IAM policies

## 🧹 Destroy Infrastructure

When the infrastructure is no longer required, Terraform can remove the resources:

```bash
terraform destroy
```

Terraform will display the resources that will be deleted and request confirmation.

To automatically confirm:

```bash
terraform destroy -auto-approve
```

**Important:** `terraform destroy` permanently removes the Terraform-managed infrastructure. Always review the destroy plan before confirming.

## 🎯 Learning Objectives

This project was built to demonstrate practical experience with:

* Infrastructure as Code
* Terraform
* AWS networking
* EC2 provisioning
* IAM
* S3
* RDS
* Application Load Balancing
* Auto Scaling
* CloudWatch
* Security Groups
* AWS architecture
* Terraform state management
* Git and GitHub

## 👨‍💻 Author

**Oshifeko Olumide**

Cloud / DevOps / Full-Stack Developer

This project is part of my hands-on cloud and DevOps learning portfolio.
