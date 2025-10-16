# Terraform AWS EC2 Module

This Terraform module creates one or more Amazon EC2 instances with customizable properties including VPC configuration, security groups, IAM roles, and storage options.

## Features

- Support for single or multiple EC2 instances
- VPC and subnet configuration
- Security group association
- IAM instance profile support
- Configurable root volume (size, type, encryption)
- User data script support
- Automatic tag management with project and environment
- Distribution of instances across multiple subnets

## Usage

### Single Instance

```hcl
module "ec2_web_server" {
  source = "github.com/your_github_username/terraform-aws-ec2"

  project_name  = "my-app"
  environment   = "production"
  ami_id        = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"
  key_pair_name = "my-ssh-key"

  # VPC Configuration
  subnet_ids         = ["subnet-12345678"]
  security_group_ids = ["sg-12345678"]

  # Optional: Root volume configuration
  root_volume_size      = 30
  root_volume_type      = "gp3"
  root_volume_encrypted = true

  additional_tags = {
    Application = "WebServer"
    ManagedBy   = "Terraform"
  }
}
```

### Multiple Instances Across Availability Zones

```hcl
module "ec2_cluster" {
  source = "github.com/your_github_username/terraform-aws-ec2"

  project_name   = "my-app"
  environment    = "production"
  instance_count = 3

  ami_id        = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.small"
  key_pair_name = "my-ssh-key"

  # Instances will be distributed across these subnets
  subnet_ids         = ["subnet-1a", "subnet-1b", "subnet-1c"]
  security_group_ids = ["sg-12345678"]

  # IAM role for EC2 instance
  iam_instance_profile = "my-ec2-role"

  # User data script
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF
}
```

### With VPC Module Integration

```hcl
module "vpc" {
  source = "github.com/your_github_username/terraform-aws-vpc"
  
  project_name       = "my-app"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.101.0/24", "10.0.102.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
}

module "ec2_instances" {
  source = "github.com/your_github_username/terraform-aws-ec2"

  project_name   = "my-app"
  environment    = "dev"
  instance_count = 2

  ami_id        = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"
  
  # Use outputs from VPC module
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = [module.vpc.security_group_id]
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | ~> 5.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_name | The name of the project, used for resource naming | `string` | n/a | yes |
| environment | The deployment environment (e.g., dev, prod) | `string` | n/a | yes |
| ami_id | The AMI ID for the EC2 instance | `string` | n/a | yes |
| instance_type | The type of EC2 instance to create | `string` | n/a | yes |
| key_pair_name | The name of the SSH key pair to associate with the instance | `string` | `null` | no |
| instance_count | Number of EC2 instances to create | `number` | `1` | no |
| security_group_ids | A list of security group IDs to associate with the instance | `list(string)` | `[]` | no |
| subnet_ids | A list of subnet IDs where instances will be launched | `list(string)` | `[]` | no |
| iam_instance_profile | The IAM instance profile to attach to the instance | `string` | `null` | no |
| user_data | User data script to run when the instance launches | `string` | `null` | no |
| root_volume_size | Size of the root volume in GB | `number` | `20` | no |
| root_volume_type | Type of root volume (e.g., gp3, gp2, io1) | `string` | `"gp3"` | no |
| root_volume_encrypted | Whether to encrypt the root volume | `bool` | `true` | no |
| additional_tags | Additional tags to apply to the instance | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance_ids | The IDs of the created EC2 instances |
| instance_public_ips | The public IP addresses of the EC2 instances |
| instance_private_ips | The private IP addresses of the EC2 instances |
| instance_arns | The ARNs of the EC2 instances |

## Notes

- **Multiple Instances**: When creating multiple instances with `instance_count > 1`, instances are automatically distributed across the provided subnets in a round-robin fashion.
- **Root Volume Encryption**: Encryption is enabled by default for security best practices.
- **IAM Roles**: If your application needs to access AWS services, create an IAM role and pass the instance profile name.
- **User Data**: User data scripts run only once at instance launch. For configuration management, consider using tools like Ansible or AWS Systems Manager.
- **SSH Keys**: The key pair must exist in AWS before using this module.

## Security Considerations

- Always use security groups with restrictive ingress rules
- Enable root volume encryption for sensitive data
- Use IAM roles instead of hardcoding AWS credentials
- Regularly update AMIs to include latest security patches
- Consider using AWS Systems Manager Session Manager instead of SSH for access
