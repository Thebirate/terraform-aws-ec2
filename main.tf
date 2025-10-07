resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
 

  # Additional configuration like security groups, VPC, etc.
  # could be added here and referenced via variables.
  # For example:
  # vpc_security_group_ids = [var.security_group_id]
  # subnet_id              = var.subnet_id
}
