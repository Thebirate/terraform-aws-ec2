variable "project_name" {
  description = "The name of the project, used for resource naming."
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod)."
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to create."
  type        = string
}

variable "key_pair_name" {
  description = "The name of the SSH key pair to associate with the instance."
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID to launch the instance in."
  type        = string
}

variable "public_subnet_ids" {
  description = "A list of IDs for the public subnets to launch instances in."
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "A list of IDs for the private subnets to launch instances in."
  type        = list(string)
}