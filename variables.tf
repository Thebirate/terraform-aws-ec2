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
  default     = null
}

variable "instance_count" {
  description = "Number of EC2 instances to create."
  type        = number
  default     = 1
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with the instance."
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "A list of subnet IDs where instances will be launched. Instances will be distributed across these subnets."
  type        = list(string)
  default     = []
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to attach to the instance."
  type        = string
  default     = null
}

variable "user_data" {
  description = "User data script to run when the instance launches."
  type        = string
  default     = null
}

variable "root_volume_size" {
  description = "Size of the root volume in GB."
  type        = number
  default     = 20
}

variable "root_volume_type" {
  description = "Type of root volume (e.g., gp3, gp2, io1)."
  type        = string
  default     = "gp3"
}

variable "root_volume_encrypted" {
  description = "Whether to encrypt the root volume."
  type        = bool
  default     = true
}

variable "additional_tags" {
  description = "Additional tags to apply to the instance."
  type        = map(string)
  default     = {}
}
